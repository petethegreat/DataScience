# Stats Notes

some notes on stats, mainly from statistical inference class

just a skeleton now. Will flesh things out later

## Bayes rule

* A is condition (e.g a disease)
* B is observation  (e.g. a positive result on a test for the disease)


* P(A|B) is the probability of A given B (i.e., how likely are we to have the disease given a positive test?)
* P(B|A) is the probability of B given A (i.e., how likely is the test to be positive when the disease is present)
    * this is the probability of a "true positive"
	* for disease tests this is called the **sensitivity**
* P(B|A<sup>c</sup>) is probability of B in the absence of A (i.e. how likely are we to have the disease when the test is false)* P(B<sup>c</sup>|A<sup>c</sup>) is probability of not B in the absence of A (i.e. how likely are we to not have the disease when the test is false)
    * this is the probability of a "true negative"
	* for disease tests this is called the **sensitivity**

* P(A) is the prevalence, or probability of the condition in the population (given no other information)

P(A|B) = P(B|A)P(A) / P(B) = P(B|A) P(A)/ ( P(B|A) P(A) + P(B|A<sup>c</sup>) P(A<sup>c</sup>))
P(A|B) = P(B|A) P(A)/ ( P(B|A) P(A) + (1- P(B<sup>c</sup>|A<sup>c</sup>)) (1-P(A)))
