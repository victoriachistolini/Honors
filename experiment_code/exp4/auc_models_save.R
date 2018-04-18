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
library(spatstat)  
library(rgdal)     
library(maptools)  
library(raster)
library(magrittr)
library(dataTools)
library(reshape2)
library(ggplot2)



auc_test_model <- function(window,day){
  
  # read in predictors data
  predictors_data <- read.csv(file="/home/vchisto/Honors/experiment_code/exp3/params_data.csv", header=TRUE, sep=",")
  
  test_data = set_up_data(window,day)
  num_obs = sum(test_data$flag)
  
  for (i in 1:nrow(predictors_data)) {
    # parse selected variables from predictors_data
    current <- predictors_data[i,]
    names <- unlist(current, use.names=FALSE)
    names= names[names != ""] 
    names = levels(names)[names[1:length(names)]]
    
    # trim dataframe to predictors wanted 
    input_points <- dplyr::select(as_data_frame(test_data$input), names)
    
    # create a model
    run_maxEnt_model(test_data$flag,input_points,i)
  }
  
}


run_maxEnt_model <- function(flag,pts,idx){
  
  # run MAXENT model
  
  mpath <- paste("/mnt/ecocast/projectdata/students/VC/m",idx,sep="")
  model <- try(dismo::maxent(pts, flag, path = mpath))
  traceback()
  
  # report model
  if (!inherits(model, 'try-error') ) {
    # extract the AUC
    cat("made model")
    
  }
  
}

set_up_data <- function(window,day){
  
  # load all default params 
  params = c("max_airtemp", "mean_airtemp", "mean_relhum", 
             "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
             "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")
  
  # set default time period 
  #SS <- as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')
  SS <- as.POSIXct(c("2006-06-01 00:00:00", "2010-12-31 00:00:00"), tz = 'UTC')
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
windows <- c(40, 40,7,3,3,3,3,15,30,15,2,2,20)

for (i in 1:length(days_vector)) {
  day = days_vector[i]
  window <- c(-windows[i], windows[i])
  auc_test_model(window,day)
}
