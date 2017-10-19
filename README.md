# Honors

A repository for organizing my research sources, notes, questions and code.


## Research Focus Questions
* **Conceptual Understanding of Models:** How do we statistically model presence only data using the MaxEnt model? 
* **Model Validation:** How can we assess forecast skill in a quantitative manner; currently we use intuitive judgment?  
* **Model Selection:** How can we compare performance between different MaxEnt models?
* **Model Interpretation:** How can we define the response variable that we are modeling? To what geographic range can we reliably extrapolate model? 
* **Model Simplification:** MaxEnt uses complex transformations on covariates such as: linear, product, quadratic, hinge, threshold, categorical, are these necessary? 
* **Future Models:** Do we need a collection of different models, could this improve performance? Do different models do better based on time of year? Could other modeling techniques be used? 
* **Human Encounter Likelihood Component:** What are novel ways that we can include human behavioral patterns more explicitly in the model? 

## Sub-Questions

* Could using differnt numbers of background points influence forecast skill?
* Is the current method of selecting background points really effective in creating a null model for the desired geographic region?
* Determine if selected parameters are good and free from correlation.
* Usage of sampling bias grids, maxent supports a weighting matrix that could be developed to weight sampling points based on demographic knowledge of population density.
* Development of an ensemble forecast using BIOMOD package which features different macheine learning tools.

## Methods

Use the BIOMOD package to explore different models: https://cran.r-project.org/web/packages/biomod2/biomod2.pdf
