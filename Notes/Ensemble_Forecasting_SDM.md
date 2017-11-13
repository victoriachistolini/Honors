

## Ensemble Models

- Using a single model, there is too much variation 
- A forecast ensemble is more narrowly defined as multiple simulations (copies) across more than one set of initial conditions (IC), model classes (MC), parameters (MP) and boundary conditions (BC) (Box 1). Each combina- tion of IC, MC, MP and BC is one possible state of the system being forecasted


Postprocessing models:
- how to combind the forecast scores? Use mean or median.
- Bayesian Model Averaging, basically a weighted average 

- Can create ensemble models in a variety of ways: 
  -> different the type of model used 
  -> different set of predictors 
  -> different bounding box
  -> different sample of observations used
  

- There are several sources of uncer- tainty in numerical weather forecasts, including uncer- tainty about initial conditions, lateral boundary condi- tions, and model physics, as well as discretization and integration methods.
- we have uncalibrated ensembles   

## Potential Experimental design using ensemble methods 

-> take bootstrap samples of the observation population and then fit MAXENT models to these different datasets.
-> create models using random selections of predictors and fit MAXENT models to these different parameter sets.


## Questions
-> is the unit of measure really a day
- Do our tick predicted observations have a degree of spatial or temporal independence from the calibration set 
- Is the MAXENT model really an ensemble in  itself?




## Source 

Ensemble forecasting of species distributions
Miguel B. Arau ́ jo1 and Mark New2
1 Department of Biodiversity and Evolutionary Biology, National Museum of Natural Sciences, CSIC, C/Gutie ́ rrez Abascal, 2, 28006, Madrid, Spain
2 Climate Research Laboratory, Oxford University Centre for the Environment, South Parks Road, Oxford, UK, OX1 3QY

Using Bayesian Model Averaging to Calibrate Forecast Ensembles
ADRIAN E. RAFTERY, TILMANN GNEITING, FADOUA BALABDAOUI, AND MICHAEL POLAKOWSKI