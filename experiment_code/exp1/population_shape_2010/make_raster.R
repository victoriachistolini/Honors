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
library(sf)


# read in maine county polygon data 
shp <- st_read("tl_2010_23_county10.shp")

# read in population density meta-data
dat <- read.csv("R11586795_SL050.csv")


# merge county polygon data and population density data
dat2 <- dat %>% dplyr::select(Geo_FIPS, SE_T002_002)
shp2 <- shp %>% 
  mutate(GEOID10 = as.integer(as.character(shp$GEOID10))) %>% 
  left_join(dat2, by=c("GEOID10" = "Geo_FIPS"))

shp3 <-  dplyr::select(shp2, SE_T002_002)

# convert the sf dataframe to a spacial points dataframe 
shp4 <-  as(shp3, 'Spatial')


# create a raster with values coming from the population density columns
ext <- extent(shp4)
rr <- raster(ext, res=0.5)
rr <- rasterize(shp4, rr, field="SE_T002_002")


#writeRaster(rr, "/Users/jhkamherst/Desktop/population_shape_2010/pop_dens")

