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
library(dataTools)
#Example of the step wise elimination method for reducing the model.

run_a_ppp <- function(SS, params, window,day,year){

  # load/format envirommental predictors
  q = process_predictor_stack(SS, params, window,day)

  # load/format tick observations
  obs = trim_prescence_points(tickdata::read_obs(), 
                            SS,
                            day, window)


  # reformat into spatstat formats
  predictors.im <-create_point_process_predictors(day,year, q)
  tick.ppp <-ticks_to_ppp(obs,year)

  #predictors
  vegtype = predictors.im$first_vegtyp
  vegcover = predictors.im$mean_vegcvr
  max_temp = predictors.im$max_airtemp
  min_temp = predictors.im$min_airtemp
  mean_temp = predictors.im$mean_airtemp
  mean_humidity = predictors.im$mean_relhum
  mean_snow_cover = predictors.im$mean_sncvr
  mean_snow_depth = predictors.im$mean_sndep
  mean_trnstr = predictors.im$mean_trnstr
  mean_uwind = predictors.im$mean_uwind
  mean_vwind = predictors.im$mean_vwind
  mean_wilt = predictors.im$mean_wilt
  precipitation = predictors.im$sum_precip
  
  # create a ppp model
  PPM1 <- ppm(tick.ppp ~ vegtype + vegcover + max_temp + min_temp + mean_temp
                         + mean_humidity + mean_snow_cover + mean_snow_depth + mean_trnstr
                         + mean_uwind + mean_vwind + mean_wilt + precipitation)
  
  PPM3 <- ppm(tick.ppp ~ vegtype + vegcover + max_temp + min_temp + mean_temp
              + mean_humidity + mean_trnstr
              + mean_uwind + mean_vwind + mean_wilt + precipitation)
  
  PPM4 <- ppm(tick.ppp ~ vegtype + vegcover + max_temp + min_temp + mean_temp
              + mean_humidity + mean_trnstr
              +  mean_vwind + mean_wilt + precipitation)
  
  
  
  PPM5 <- ppm(tick.ppp ~ vegtype + vegcover + max_temp  + mean_temp
              + mean_humidity + mean_trnstr
              +  mean_vwind + mean_wilt + precipitation)
  
  PPM6 <- ppm(tick.ppp ~ vegtype + vegcover + max_temp  + mean_temp
              + mean_humidity + mean_trnstr
              +  mean_vwind + mean_wilt )
  
  PPM7 <- ppm(tick.ppp ~ vegtype + vegcover + max_temp  + mean_temp
              + mean_humidity + mean_trnstr
              +  mean_vwind  )
  
  PPM8 <- ppm(tick.ppp ~ vegtype + vegcover + max_temp 
              + mean_humidity + mean_trnstr
              +  mean_vwind  )

  
  PPM9 <- ppm(tick.ppp ~ vegtype + vegcover + max_temp 
               + mean_trnstr
              +  mean_vwind  )
  
  # all significant terms 
  PPM10 <- ppm(tick.ppp ~   vegcover + max_temp 
              + mean_trnstr
              +  mean_vwind  )
  
  
  PPM2 <- ppm(tick.ppp ~  mean_snow_cover)
  

}



###### Parameters ######
window = c(-3,3)
day = 150
params = c("first_vegtyp", "max_airtemp", "mean_airtemp", "mean_relhum", 
           "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
           "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")
year = "2007"

SS = as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')
run_a_ppp(SS, params, window,day,year)
