# Tutorial Taken from: http://www.will.chez-alice.fr/pdf/BiomodTutorial.pdf
# Edits made by Victoria Chistolini
# work on SMD 

# Install Dependant Packages
myPackages <- .packages(all = TRUE)
biomodDependencies <- c('rpart','MASS', 'gbm', 'gam', 'nnet', 'mda',
                        'randomForest', 'Hmisc', 'plyr', 'foreign',
                        'sp', 'rgdal', 'raster', 'maptools') # compare my packages whith those required by BIOMOD
missingPackages <- biomodDependencies[!(biomodDependencies
                                        %in% myPackages)]
# uncomment install.packages() and choose a miror to install
# missing components
if(length(missingPackages) > 0){
  cat(toString(missingPackages), ' packages have to be installed\n')
  install.packages(missingPackages, dependencies=T) } else{ cat('All dependences are installed\n')}


# Now we can install BIOMOD!
if(!('BIOMOD' %in% myPackages)){
install.packages("BIOMOD", repos="http://R-Forge.R-project.org") } else { cat('BIOMOD is already installed')}

# load BIOMOD package
library(BIOMOD)


# feed in correct coloms of data set
Initial.State(Response = Resp.Var[,1:2], Explanatory = Expl.Var)


Models(
  #Setting the models to TRUE or FALSE (to run them or not) and their as- sociated options (please refer to the Presentation Manual)
  GLM=FALSE, TypeGLM="simple", Test="AIC",
  GBM=FALSE, No.trees= 5000,
  GAM=FALSE, Spline=3, CTA=FALSE, CV.tree=50, ANN=FALSE, CV.ann=5, SRE=FALSE, quant=0.025, FDA=FALSE, MARS=FALSE, RF=FALSE,
  #The calibration procedure options
  NbRunEval=1, DataSplit=100,
  NbRepPA=0, strategy="sre", coor=NULL, distance=0, nb.absences=NULL, Yweights=NULL,
  #The evaluation procedure options
  VarImport=0,
  Roc=FALSE, Optimized.Threshold.Roc=FALSE, Kappa=FALSE, TSS=FALSE, KeepPredIndependent=FALSE
)





