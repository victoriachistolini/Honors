#BIOMOD R-Platform for building forecast ensambles 

Help make models much more robust and to handle different: 
fit ensembles of forecasts by simulating across more than one set of initial conditions, model classes, model parameters, and boundary conditions 



* incorporates several features for testing models (e.g. k-fold cross validation) 
* examining species-environment relationships (e.g. using randomization tests)

* Currently, BIOMOD enables larger simulations across initial conditions (i.e. by randomly re-sampling species distribution data and fitting different models for each sample), nine model classes (generalised linear models (GLM, McCullagh and Nelder 1989), generalised additive models (GAM, Hastie and Tibshirani 1990), multivariate adaptive regression splines (MARS, Friedman 1991), classification tree analysis (CTA, Breiman et al. 1984), mixture discriminant analysis (MDA, Hastie et al. 1994), artificial neural networks (ANN, Ripley 1996), generalised boosted models (GBM, Ridgeway 1999), random forests (Breiman 2001), and one rectilinear envelope similar to BIOCLIM (SRE, Busby 1991)), 

When non-independent data are used for model evaluation, variability in model accuracy should be interpreted as a measure of the sensitivity of model results to the initial conditions rather than as a measure of predictive accuracy 

alternative is to combine models using some form of weighting (e.g. using PCA score value

randomisation procedure to estimate the importance of each variable.


## Experimental design with BioMod:
* generate a dataset of absences and pseudo absences. 
* dataset needs to be in the following order: idw (ID), X and Y, Var1, Var2, Sp
* set Initial.State function to describe dataset structure
* Yweights can add a weight to certain datapoints




#Source 
http://onlinelibrary.wiley.com/doi/10.1111/j.1600-0587.2008.05742.x/full