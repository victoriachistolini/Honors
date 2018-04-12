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
library(tmap)

# read in predictors data
predictors_data <- read.csv(file="/home/vchisto/Honors/experiment_code/exp3/params_data.csv", header=TRUE, sep=",")



v2 <- raster("/home/vchisto/veg_raster_data/v2.tif")
v3 <- raster("/home/vchisto/veg_raster_data/v3.tif")
v4 = v2+v3

day = days_vector[1]
window <- c(-windows[1], windows[1])

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
background_points <- extract_back_points(predictor_stack,obs, NBACK)




current <- predictors_data[1,]





params = c("max_airtemp", "mean_airtemp", "mean_relhum", 
           "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
           "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")

days_vector <- c(15,46,74,105,135,146,166,196,227, 258, 288, 319, 349 )
windows <- c(40, 40,7,3,3,3,3,15,30,15,2,2,20)
SS <- as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')
