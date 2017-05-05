# Machine Learning Notes

## Error rates

Reminder on errors. Consider (again) a test used to predict whether or not someone has a disease.


|  |  |disease| | 
|:------|----:|-----------:|-----------:|
|   |  |Present | Absent |
|**test** |positive | TP | FP |
| |negative | FN | TN |  

* Sensitivity is the probability to test positive in the prescence of the disease
    * P(positive test| disease) = TP/( TP + FN)
* Specificity is the probability to test negative in the absence of the disease
    * P(negative test| no disease) = TN/( TN + FP)
* Positive predictive value is the probability of having the disease given a positive test
    * P(disease|positive test) = TP/( TP + FP)
* Negative predictive value is the probability of not having the disease given a negative test
    * P(no disease|negative test) = TN/( TN + FN)
* Accuracy is the probability of the test giving the correct result
    * P = TN + TP)/(TP + FP + TN + FN)

	


