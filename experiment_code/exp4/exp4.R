# code to generate forcast auc 

predictors_data <- read.csv(file="/home/vchisto/Honors/experiment_code/exp3/params_data.csv", header=TRUE, sep=",")
  i = 1
  current <- predictors_data[i,]
  names <- unlist(current, use.names=FALSE)
  names1= names[names != ""] 
  names= names1[names1 != "v4"] 
  names = levels(names)[names[1:length(names)]]

  path <- paste("/mnt/ecocast/projectdata/students/VC/m",i,sep="")
  model = dismotools::read_maxent(path)
  
  for (i in 1:length(dates)) {
  
     predictors = namtools::read_archived_forecast(dates[1])
  }
  
  #xcast = dismo::predict(model, predictors)
  #fauc = dismotools::auc_raster(xcast, test_obs)


dates = c("20110115", "20110215", "20110314", "20110414", "20110514", "20110625", "20110714", "20110814", "20110914", "20111014", "20111114", "20111214")
dates2 = c("20120115", "20120215", "20120314", "20120414", "20120514", "20120625", "20120714", "20120814", "20120914", "20121014", "20121114", "20121214")
dates2 = c("20130115", "20130215", "20120314", "20120414", "20120514", "20120625", "20120714", "20120814", "20120914", "20121014", "20121114", "20121214")

days_vector <- c(15,46,74,105,135,146,166,196,227, 258, 288, 319, 349 )
