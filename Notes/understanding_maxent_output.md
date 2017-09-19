#MaxEnt Output


#The coeficients (Lambda File)

The coefficients of the Maxent model for a species are output in a
  file called species.lambdas.  The entries in the lambdas file are
  lines of the form: (feature, lambda, min, max).  The exponent
  of the Maxent model is calculated as:


  exponent = lambda<sub>1</sub> * (f<sub>1</sub>(x)-min<sub>1</sub>)/(max<sub>1</sub> - min<sub>1</sub>) + ... + lambda<sub>n</sub> * (f<sub>n</sub>(x)-min<sub>n</sub>)/(max<sub>n</sub> -min<sub>n</sub>) - linearPredictorNormalizer

In other words, features are scaled so that their values would lie
between 0 and 1 on the training data.  By default, all features are
clamped prior to projection of the model
onto new data - see section "Projections" above.
The linearPredictorNormalizer is
a constant chosen so that the exponent is always non-positive (for
numerical stability).
Terms corresponding to hinge features are evaluated slightly
differently.  For example, the hinge feature prec' derived from the
layer prec and described by the line:  (prec', lambda, min, max)
evaluates to the term

  lambda * clamp_at_0(prec-min)/(max-min)

i.e., if prec&lt min then the value is 0 otherwise it is (prec-min)/(max-min).
For the reverse hinge feature
  (prec`, lambda, min, max),
the term is

  lambda * clamp_at_0(max-prec)/(max-min)

The densityNormalizer is the normalization term Z calculated over the
background.  The Maxent raw output is therefore:

  raw = exp(sum lambda<sub>i</sub> * (f<sub>i</sub>(x)-min<sub>i</sub>)/(max<sub>i</sub> - min<sub>i</sub>) - linearPredictorNormalizer) / densityNormalizer

Lastly, logistic output is calculated using the entropy given at
the end of the lambda file:  

  logistic = raw * exp(entropy) / (1 + raw * exp(entropy)).

#Source
https://github.com/mrmaxent/Maxent/blob/master/density/help.html.pre

