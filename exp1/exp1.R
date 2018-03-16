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

window = c(-3,3)
params = c("first_vegtyp", "max_airtemp", "mean_airtemp", "mean_relhum", 
           "mean_sncvr", "mean_sndep", "mean_trnstr", "mean_uwind", "mean_vegcvr", 
           "mean_vwind", "mean_wilt", "min_airtemp", "sum_precip")


# days between 119 and 266 are classified as summer
#summer_days = c(119,126,133,140,147,154,161,168,175,182,
                #189,196,203,210,217,224,231,238,245,252,259,266)


# between days 273 and 322 are classified as fall 
fall_days = c(273, 280, 287, 294, 301, 308, 315, 322, 329, 336)
data = create_multi_week_set(fall_days, window, params)
corr_matrx(data,length(params),"fall.csv")

# days between 343 and are classified as winter 
winter_days = c(343,350,357,364,7,14,21,28,35,42,49,56,63,70 )
data = create_multi_week_set(winter_days, window, params)
corr_matrx(data,length(params),"winter.csv")


# days between 77 and 154
spring_days = c(77,84,91,98,105,112,119,126,133,140,147,154 )
data = create_multi_week_set(spring_days, window, params)
corr_matrx(data,length(params),"winter.csv")

all_year = c(7,14,21,28,35,42,49,56,63,70,77,84,91,98,
             105,112,119,126,133,140,147,154, 161,168,
             175,182,189,196,203,210,217,224,231,238,
             245,252,259,266, 273, 280, 287, 294, 301,
             308, 315, 322, 329, 336,343,350,357,364 )

