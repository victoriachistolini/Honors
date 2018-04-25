# code to generate forcast auc 
library(raster)
library(dismotools)
library(dataTools)
library(dplyr)

# load paths of archived raster layers
load_predictors <- function(){
  
  # list the files in the 'day-brick' directory
  ff <- list.files('/mnt/ecocast/coredata/nam218/nwa/day-brick',
                   pattern = glob2rx("*.grd"),
                   full.names = TRUE)
  names(ff) <- gsub(".grd", "", basename(ff))
  
  PP <- lapply(ff,
               function(filename){
                 raster::brick(filename)
               })
  return(PP)
  
}


parse_predictor_brick <- function(date = "A2011015", params=c("mean_airtemp", "max_airtemp"), pstack = load_predictors()){
  
  parse_stack <- lapply(params, function(current_name){
    pstack[[current_name]][[date]]
    
  })
  names(parse_stack) <- params
  return(stack(parse_stack))
}




run_func <- function(day, path_m, additional_params, archived_forecast_lib, testObs){
  
  fauc_scores = vector()
  
  # for each model
  for (i in 1:32){
    
    # load maxent model from given path 
    mpath <- paste(path_m,i,sep="_")
    model = dismotools::read_maxent(mpath)
    
    if (dismotools:model_successful(model)){
    
      # get params used in maxent model
      params = names(dismotools::maxent_get_results(model, 'contribution'))
    
      v4Flag <- "v4" %in% params
    
      # archievd data does not contain veg binary
      loadParams = params[params != "v4"]
    
      # load archived data
      pstack = parse_predictor_brick(day,loadParams,archived_forecast_lib)
    
      if (v4Flag){
        pstack <- addLayer(pstack,additional_params)
      }
    
      # update names
      names(pstack) = params
    
      # create forecast
      xcast = dismo::predict(model, pstack)
    
     
      # assess forcast sucess 
      out = dismotools::auc_raster(xcast, testObs)
      fauc_scores[i] = out$area
    } else {
      fauc_scores[i] = NA
    }
    
    }
    
    # maybe save xcast > write raster? 
    return(fauc_scores)
  }
  
  
  

#load forecast library 

predictorSet = load_predictors()

# load the veg cover raster binary raster
v2 <- raster("/mnt/ecocast/projectdata/students/VC/veg_raster_data/v2.tif")
v3 <- raster("/mnt/ecocast/projectdata/students/VC/veg_raster_data/v3.tif")
v4 = v2+v3

# doy dates
days_vector <- c(15,46,74,105,135,146,166,196,227, 258, 288, 319, 349 )
windows <- c(40, 40,7,3,3,3,3,15,30,15,2,2,20)


# different set of dates to try out
dates = c("20110115", "20110215", "20110314", "20110414", "20110514", "20110525","20110614", "20110714", "20110814", "20110914", "20111014", "20111114", "20111214")

# here they are in the form we need them which is "AYYYYjjj" (It's a long story)
adates <- format(as.Date(dates, format = "%Y%m%d"), "A%Y%j")

auc_scorez <- list()

# loop over dates day, dayIdx, doy, additional_params, archived_forecast_lib
#for (i in 1:1) {
  i=1
  # generate test obs
  SS <- as.POSIXct(c("2010-12-31 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')
  testObs = load_trimmed_tick_obs(SS,days_vector[i],c(-windows[i],windows[i]))
  testObs = testObs[,c("x","y")]
  
  path = paste("/mnt/ecocast/projectdata/students/VC/m", days_vector[i], sep="")
  auc_scorez[[i]] = run_func(adates[i], path, v4, predictorSet, testObs)
#}
# write out fauc scores 
dd  <-  as.data.frame(matrix(unlist(auc_scorez), nrow=length(unlist(auc_scorez[1]))))
write.csv(dd, file = "fauc_scores.csv")

#dates2 = c("20120115", "20120215", "20120314", "20120414", "20120514", "20120625", "20120714", "20120814", "20120914", "20121014", "20121114", "20121214")
#dates3 = c("20130115", "20130215", "20130314", "20130414", "20130514", "20130625", "20130714", "20130814", "20130914", "20131014", "20131114", "20131214")