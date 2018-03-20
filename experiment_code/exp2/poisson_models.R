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


# 3 vs 7 day window, had twice as many points but came to the same conclusions...

# load covariates and extract values into dataset
predictor_stack <- process_predictor_stack(SS, params, window, day)
dataset <- create_point_process_dataset(SS,day, window,predictor_stack)



# covariates converted to image format
first_veg <- compress_predictor_stack(predictor_stack[[1]])
max_airtemp <- compress_predictor_stack(predictor_stack[[2]])
mean_airtemp <- compress_predictor_stack(predictor_stack[[3]])
mean_humidity <- compress_predictor_stack(predictor_stack[[4]])
trnstr <- compress_predictor_stack(predictor_stack[[7]])
uwind <- compress_predictor_stack(predictor_stack[[8]])
mean_vegcvr <- compress_predictor_stack(predictor_stack[[9]])
vwind <- compress_predictor_stack(predictor_stack[[10]])
wilt <- compress_predictor_stack(predictor_stack[[11]])
min_airtemp <- compress_predictor_stack(predictor_stack[[12]])
sum_precip <- compress_predictor_stack(predictor_stack[[13]])

# obs converted to ppp format
#tick.ppp <- convert_obs(dataset)

vecvr <- mean(predictor_stack[[9]])
tick.sp <- SpatialPoints( dataset[,c("x","y")],CRS(proj4string(vecvr)))
ticks.ppp  <- as(tick.sp, "ppp")

tm_shape(World,bbox="Maine") + tm_polygons("MAP_COLORS", palette="Pastel2") +
  tm_shape(tick.sp) + tm_bubbles(col="red", alpha=0.5, 
                            border.col = "yellow", border.lwd = 0.5, scale = 0.5) + 
  tm_legend(outside = TRUE, text.size = .8) 

tm_shape(World,bbox="Maine") + tm_polygons("MAP_COLORS", palette="Pastel2") +
  tm_shape(tick.sp) + tm_bubbles(col="red", alpha=0.5, 
                                 border.col = "yellow", border.lwd = 0.5, scale = 0.5) + 
  tm_legend(outside = TRUE, text.size = .8) 


tmp <- tempfile()
download.file("http://colby.edu/~mgimond/Spatial/Data/Income_schooling.zip", destfile = tmp)
unzip(tmp, exdir = ".")
s1 <- readOGR(".", "Income_schooling")

tm_shape(s1) +  tm_polygons("MAP_COLORS", palette="Greys") +
  tm_shape(tick.sp) + tm_bubbles(col="red", alpha=0.5, 
                                 border.col = "yellow", border.lwd = 0.5, scale = 0.5) + 
  tm_legend(outside = TRUE, text.size = .8) 


# do some analysis with the dataset values 
d_cor <- as.matrix(cor(dataset[,params]))
d_cor_melt <- arrange(melt(d_cor), -abs(value))
d_cor_melt <- dplyr::filter(d_cor_melt, value > .5)
d_cor_melt <- dplyr::filter(d_cor_melt, value != 1)
#d_cor_melt <- dplyr::distinct(d_cor_melt, value)

PPM0 <- ppm(tick.ppp ~ mean_airtemp + mean_humidity + mean_vegcvr + uwind + vwind + sum_precip )
PPM1 <- ppm(tick.ppp ~ min_airtemp + mean_humidity + mean_vegcvr + uwind + vwind + sum_precip )
PPM2 <- ppm(tick.ppp ~ max_airtemp + mean_humidity + mean_vegcvr + uwind + vwind + sum_precip )
PPM3 <- ppm(tick.ppp ~ mean_airtemp + mean_humidity + uwind  + sum_precip )
PPM4 <- ppm(tick.ppp ~ mean_airtemp + mean_humidity + trnstr + uwind + vwind + sum_precip )

anova( PPM4,PPM3, test="LRT")

plot(effectfun(PPM3,  c("mean_airtemp" , "mean_humidity" , "uwind"  , "sum_precip"), se.fit=TRUE), main=NULL, cex.axis=0.6,cex.lab=0.6,
     legend=FALSE)


# CONSTANTS AND PARAMETERS
window = c(-7,7)
day = 150
params = c("first_vegtyp", "max_airtemp", "mean_airtemp", "mean_relhum", 
           "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
           "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")

SS = as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')

PROJ <- c(longlat =  "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0",
          lcc = "+proj=lcc +lat_1=25 +lat_0=25 +lon_0=-95 +k_0=1 +x_0=0 +y_0=0 +a=6367470.21484375 +b=6367470.21484375 +units=km +no_defs")

# create a single raster, from stack
compress_predictor_stack <- function(raster_stack){
  
  single_raster <- mean(raster_stack)
  raster.im <- as.im(single_raster)
  
  return(raster.im)
  
}