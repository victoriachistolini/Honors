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


# load covariates and extract values into dataset
predictor_stack <- process_predictor_stack(SS, params, window, day)
#dataset <- create_point_process_dataset(SS,day, window,predictor_stack)
obs = load_trimmed_tick_obs(SS,day,window)
# get values from covariate images
prescence_points <- extract_precsence_points(predictor_stack,obs)

# create dataset with obs and prescence points
dataset <- cbind(obs,prescence_points)

# look at distribution of vegitation types
hist(dataset$first_vegtyp, main="histogram of veg type")


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


# bindary vegtype rasters 
v1 <-as.im( raster("/home/vchisto/veg_raster_data/v1.tif"))
v2 <- as.im(raster("/home/vchisto/veg_raster_data/v2.tif"))
v3 <- as.im(raster("/home/vchisto/veg_raster_data/v3.tif"))

v4 = v2+v3

# obs converted to ppp/sp format
tick.sp <- SpatialPoints( dataset[,c("x","y")],CRS(PROJ))
ticks.ppp  <- as(tick.sp, "ppp")

# load maine state boundries/extent
s2 <- readOGR("/home/vchisto/maine_shape_data", "Income_schooling")
s22 <- spTransform(s2, CRS(PROJ))

# restrict tick.ppp extent to maine state window
W  <- as(s22, "owin")
Window(ticks.ppp) <- W
plot(ticks.ppp)

# plot the observations 
tm_shape(s22) +  tm_polygons("MAP_COLORS", palette="Greys") +
  tm_shape(tick.sp) + tm_bubbles(col="red", alpha=0.5, 
                                 border.col = "yellow", border.lwd = 0.5, scale = 0.5) + 
  tm_legend(outside = TRUE, text.size = .8) 


# do some correlations analysis 
d_cor <- as.matrix(cor(dataset[,params]))
d_cor_melt <- arrange(melt(d_cor), -abs(value))
d_cor_melt <- dplyr::filter(d_cor_melt, value > .5)
d_cor_melt <- dplyr::filter(d_cor_melt, value != 1)


PPM0 <- 	ppm(ticks.ppp ~  mean_airtemp+ uwind+ vwind+ sum_precip+trnstr )


PPM0 <- 		ppm(ticks.ppp ~ first_veg+max_airtemp + mean_airtemp+ mean_humidity+ trnstr+ uwind+mean_vegcvr+ vwind+ wilt + min_airtemp + sum_precip )

anova( PPM0,PPM1, test="LRT")



# CONSTANTS AND PARAMETERS
window = c(-3,3)
day = 292
params = c("first_vegtyp", "max_airtemp", "mean_airtemp", "mean_relhum", 
           "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
           "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")

SS = as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')

PROJ <- "+proj=lcc +lat_1=25 +lat_0=25 +lon_0=-95 +k_0=1 +x_0=0 +y_0=0 +a=6367470.21484375 +b=6367470.21484375 +units=km +no_defs"

# create a single raster, from stack
compress_predictor_stack <- function(raster_stack){
  
  single_raster <- mean(raster_stack)
  raster.im <- as.im(single_raster)
  
  return(raster.im)
  
}