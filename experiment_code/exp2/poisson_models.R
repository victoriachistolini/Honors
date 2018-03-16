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

# load covariates and extract values into dataset
predictor_stack <- process_predictor_stack(SS, params, window, day)
dataset <- create_point_process_dataset(SS,day, window,predictor_stack)

# covariates converted to image format
predictors.im <- convert_predictors_to_im(predictor_stack)

# obs converted to ppp format
tick.ppp <- convert_obs(dataset)


# list out params



# create a ppm model



# do some analysis with the dataset values 





# CONSTANTS AND PARAMETERS
window = c(-3,3)
day = 150
params = c("first_vegtyp", "max_airtemp", "mean_airtemp", "mean_relhum", 
           "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
           "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")
year = "2007"

SS = as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')
run_a_ppp(SS, params, window,day,year)

PROJ <- c(longlat =  "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0",
          lcc = "+proj=lcc +lat_1=25 +lat_0=25 +lon_0=-95 +k_0=1 +x_0=0 +y_0=0 +a=6367470.21484375 +b=6367470.21484375 +units=km +no_defs")

