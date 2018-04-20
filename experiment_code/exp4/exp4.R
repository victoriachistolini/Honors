# code to generate forcast auc 


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
  
}

run_func <- function(day, window){
  # paramaters dataset 
  predictors_data <- read.csv(file="/home/vchisto/Honors/experiment_code/exp3/params_data.csv", header=TRUE, sep=",")
 
  # load the veg cover raster binary raster
  v2 <- raster("/home/vchisto/veg_raster_data/v2.tif")
  v3 <- raster("/home/vchisto/veg_raster_data/v3.tif")
  v4 = v2+v3
  
  # load predictors and add the veg cover raster to the brick
  load_predictors()
  xx <- crop (v4,  extent(-77.1,-50.9,37.1,56.7))
  predictorz <- crop(predictors,  extent(-77.1,-50.9,37.1,56.7))
  predictors <- addLayer(predictors,v4)


  # for each model
  for (i in 1:nrow(predictors_data)){

    current <- predictors_data[i,]
    names <- unlist(current, use.names=FALSE)
    names1= names[names != ""] 
    names= names1[names1 != "v4"] 
    names = levels(names)[names[1:length(names)]]

    # load 
    path <- paste("/mnt/ecocast/projectdata/students/VC/m",i,sep="")
    model = dismotools::read_maxent(path)
  
    xcast = dismo::predict(model, predictors)
    fauc = dismotools::auc_raster(xcast, test_obs)
  }
  
}

# loop over dates

# different set of dates to try out
dates = c("20110115", "20110215", "20110314", "20110414", "20110514", "20110625", "20110714", "20110814", "20110914", "20111014", "20111114", "20111214")

# here they are in the form we need them which is "AYYYYjjj" (It's a long story)
adates <- format(as.Date(dates, format = "%Y%m%d"), "A%Y%j")


#dates2 = c("20120115", "20120215", "20120314", "20120414", "20120514", "20120625", "20120714", "20120814", "20120914", "20121014", "20121114", "20121214")
#dates3 = c("20130115", "20130215", "20130314", "20130414", "20130514", "20130625", "20130714", "20130814", "20130914", "20131014", "20131114", "20131214")
#desired projections 
#current_proj = "+proj=lcc +lat_1=25 +lat_0=25 +lon_0=-95 +k_0=1 +x_0=0 +y_0=0 +a=6367470.21484375 +b=6367470.21484375 +units=km +no_defs"
