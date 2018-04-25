library(dplyr)
library(tibble)
library(sp)
library(namtools)
library(raster)
library(dismo)
library(dismotools)
library(tickdata)
library(rscripting)
library(binaryLogic)
library(rgdal)     
library(raster)
library(magrittr)
library(dataTools)



# get window size , auc associations 
auc_test_model <- function(day,windows){
  
  auc_scores = vector()
  num_obs = vector()
  
  
  for (i in 1:length(windows)) {

    test_data = set_up_data(windows[i],day)
    num_obs[i] = sum(test_data$flag)
    
    auc_scores[i] = run_maxEnt_model(test_data$flag,test_data$input)
  }
  
  return(list("scores" = auc_scores, "obs" = num_obs))
  
}


run_maxEnt_model <- function(flag,pts){
  
  # run MAXENT model
  
  mpath <- "/dev/shm/model"
  model <- try(dismo::maxent(pts, flag, path = mpath))
  traceback()
  
  # store model
  if (!inherits(model, 'try-error') ) {
    # extract the AUC
    auc <- dismotools::maxent_get_results(model, 'auc')
    
  }
  
  #delete model
  if (dir.exists(mpath)) unlink(mpath, force = TRUE, recursive = TRUE)

  return(auc)
}

set_up_data <- function(window,day){
  
  # load all default params 
  params = c("mean_airtemp", "mean_relhum","mean_vegcvr", "mean_vwind", "mean_uwind","sum_precip" )
  
  # set default time period 
  SS <- as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')
  # format binary veg-type raster
  v2 <- raster("/home/vchisto/veg_raster_data/v2.tif")
  v3 <- raster("/home/vchisto/veg_raster_data/v3.tif")
  v4 = v2+v3
  
  # load covariates and extract values into dataset
  predictor_stack <- process_predictor_stack(SS, params, window, day)
  
  obs = load_trimmed_tick_obs(SS,day,window)
  
  # extract vals from v4
  nc <- as.integer(raster::ncell(v4))
  cell <- cellFromPts(v4, obs)
  out <- raster::getValues(v4)[cell]
  
  # get values from covariate images
  prescence_points <- extract_precsence_points(predictor_stack,obs)
  prescence_points["v4"] <- out
  background_points <- extract_back_points_ex(predictor_stack,obs, 1000,v4)
  
  flag <- c(rep(1, nrow(prescence_points)), rep(0, nrow(background_points)))
  input <- rbind(prescence_points, background_points)
  
  return(list("flag" = flag, "input" = input))
  
}

# modified extract_background to deal with new variable v4
extract_back_points_ex <- function(pp,obs,nback,v4){
  
  bkgpts <- dismotools::layers_randomPoints(pp[[1]], N = nback,
                                            pts = obs %>% dplyr::select(x,y,layer) %>% as.data.frame())
  bkgpts <- tibble::as.tibble(bkgpts)
  
  bkg <- sapply(names(pp),
                function(pname, x = NULL){
                  dismotools::layers_extractPoints(pp[[pname]], x)
                },
                x = bkgpts %>% dplyr::select(x = lon, y = lat, layer) %>% as.data.frame(),
                simplify = FALSE)
  bkg <- as.data.frame(bkg)
  cat("finishing up with dataframe")
  nc <- as.integer(raster::ncell(v4))
  cell <- cellFromPts(v4, bkgpts)
  out <- raster::getValues(v4)[cell]
  bkg["v4"]<-out
  
  
  return(bkg)
  
}


days_vector <- c(15,46,74,105,135,146,166,196,227, 258, 288, 319, 349 )
windows <- c(2,3,7,15,20,30,40)
auc_scorez <- list()
num_obs = list()

#for (i in 1:length(days_vector)) {
  i=1
  day = days_vector[i]
  out <- auc_test_model(day,windows)
  num_obs[[i]] <- out$obs
  auc_scorez[[i]] = out$scores
#}

# write out to csv 
dd  <-  as.data.frame(matrix(unlist(auc_scorez), nrow=length(unlist(auc_scorez[1]))))
ddd  <-  as.data.frame(matrix(unlist(num_obs), nrow=length(unlist(num_obs[1]))))

write.csv(dd, file = "auc_scores.csv")
write.csv(dd, file = "auc_scores_obs.csv")