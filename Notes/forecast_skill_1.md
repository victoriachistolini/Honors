# Forecast Skill



* What are some ways that the forceast has been imporved in the psat?
- better resolution data, more complex physical parameterizations, imporove estimate of the ititial condition (WHAT IS THIS??)

* Another possible way of improving weather forecasts is to adjust the forecast model output based on a da- tabase of retrospective forecasts from the same model. The adjustment of dynamically based forecasts with sta- tistical models has a rich history

* USing MOS for removing model bias.

* Initial Conditions: a set of seven bred pairs of initial conditions
* seperate regression analysis is performed for each day?
* cross validation use all data except the year which you plan to use!

* evaluate using cross validation and ranked probability skill score

* CPC forecasts are not based primarily on the raw ensemble probabilities; instead they rely on guidance from a number of ensem- ble forecast systems and statistical methods.

Overall, it seems as though the use of ensemble forecast techniques are a good option because we can get away with using less training data, even if the training data is biased?? It is overall less computationally expensive, but suffers due to lack of skill. So the need of another method to re-cast from the ensamble using MOS for example, is necessary to improve skill.

#Source

Ensemble Reforecasting: Improving Medium-Range Forecast Skill Using Retrospective Forecasts