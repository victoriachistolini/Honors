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



predictor_stack <- process_predictor_stack(SS, params, window, day)
first_veg <-  mean(predictor_stack[[1]])

###### v3 #####


plot(first_veg)
first_veg2 <- first_veg

first_veg2[] <- ifelse(first_veg[]>10 & first_veg[]<12 , 1, 0)
plot(first_veg2)

#send raster to file
path = "/home/vchisto/veg_raster_data/v3.tif"
writeRaster(first_veg2, path, format="GTiff")






####Constants
# CONSTANTS AND PARAMETERS
window = c(-7,7)
day = 150
params = c("first_vegtyp", "max_airtemp", "mean_airtemp", "mean_relhum", 
           "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
           "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")

SS = as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')

PROJ <- c(longlat =  "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0",
          lcc = "+proj=lcc +lat_1=25 +lat_0=25 +lon_0=-95 +k_0=1 +x_0=0 +y_0=0 +a=6367470.21484375 +b=6367470.21484375 +units=km +no_defs")