# code to generate forcast auc 



model = dismotools::read_maxent(path)
predictors = namtools::read_archived_forecast(date)
xcast = dismo::predict(model, predictors)
fauc = dismotools::auc_raster(xcast, test_obs)