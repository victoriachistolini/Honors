# code to generate forcast auc 

predictors_data <- read.csv(file="/home/vchisto/Honors/experiment_code/exp3/params_data.csv", header=TRUE, sep=",")
current <- predictors_data[1,]
names <- unlist(current, use.names=FALSE)
names= names[names != ""] 
names= names[names != "v4"] 
names = levels(names)[names[1:length(names)]]

model = dismotools::read_maxent(path)
predictors = namtools::read_archived_forecast()
xcast = dismo::predict(model, predictors)
fauc = dismotools::auc_raster(xcast, test_obs)

