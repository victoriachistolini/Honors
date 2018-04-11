# code to generate a plot of # observations per day 
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

obs_vals <- vector()
days <- vector()

for (i in 1:365) {
  obs_df = load_trimmed_tick_obs(SS,i,window)
  obs_vals[i]= nrow(obs_df)
  days[i] = i
}

plot(days,obs_vals, xlab = "Day of Year", ylab = "Number of Tick Observations" )

# constants
SS = as.POSIXct(c("2006-06-01 00:00:00", "2013-12-31 00:00:00"), tz = 'UTC')
PROJ <- "+proj=lcc +lat_1=25 +lat_0=25 +lon_0=-95 +k_0=1 +x_0=0 +y_0=0 +a=6367470.21484375 +b=6367470.21484375 +units=km +no_defs"
window = c(0,0)
day = 139