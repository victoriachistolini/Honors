# MaxEnt

* maxEnt is a classifier, which is used to model prescence only species data : meaning that the data only contains information as to where the species is located but not data on where it is not located. We are trying to estimate the distribution of the species across geogrpahic space.


# MaxEnt Goals

- minimize the relative entropy between two probability densities: the prescence data locations and the covariate space (enviromnetal inputs).

- Input variables (covariates) undergo a variety of transformations:
- Transformations help to model the complexity of the relationships between the species and its environment:

      - Linear
      - Product
      - quadratic
      - hinge <- change in gradient in response, piecewise linear spline
      - threshold <- "step" in fitted function
      - categorical

# Creating Covariate Distributions
If L is a geographic region of interest

L1 ⊂  L represents where the species is located (this distribution is unknown to the modeler)

L2 ⊂ L1 represents a random sampling of locations from L1, where the species has been observed

L3 ⊂ L represent a set of background points that are a random sample of L, which represent the null model.

f(z) is probability density of covarites on L, use L3 to approximate this.

f1(z) is the probability density of covariates on L1, use L2 to approximate this.

Then Bayes’ rule gives:
Pr(y = 1 | z) = f1(z)Pr(y = 1)/f(z)

# Coeficient Estimation
- constraints 

# Role of Background Points
- Background points are used to define the null models such that species have no preference in region. 
- Background points determine interpretation of the model, they also determine how much extrapolation will be occuring based on how you are trying to define your lanscape range.
- Are a way of dealing with sample selection bais, which occurs when the prescence of a species is over sampled at certian locations and undersampled at other locations.


# Interpreting the Result

- MaxEnt is modeling the probability of the prescence of a species given (based on) the enviromnetal conditions.
- With prescence only data we are unable to determine the prevalence of a species.


## Src Citation
A statistical explanation of MaxEnt for ecologists
Jane Elith1*, Steven J. Phillips2, Trevor Hastie3, Miroslav Dudı ́k4, Yung En Chee1 and Colin J. Yates5
