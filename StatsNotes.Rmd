# Stats Notes

## Conditional probability - Bayes Rule

* $P(A)$ - the probability of A occuring
* $P(A \cap B)$ - the intersection - the probability of both $A$ and $B$ occuring
* $P(A \cup B)$ - the union - the probability of $A$ or $B$ (or both) occuring

Note that 
$$
P(A \cup B) = P(A) + P(B) - P(A \cap B)
$$
The probability of both $A$ and $B$ occuring is not neccasrily just their sum, as this double counts the intersection. This is why avangers don't have double the crit rate of other classes, if you roll double 20s, it only counts as one crit. If $A$ is a roll of 20 on one die, and $B$ is a roll of 20 on the other, then the probabilty of a crit is given by $P(A \cap B)$, which is $1/20 + 1/20 - 1/20 \times 1/20 = 0.0975$

## Bayes rule

* A is condition (e.g a disease)
* B is observation  (e.g. a positive result on a test for the disease)


* $P(A|B$) is the probability of A given B (i.e., how likely are we to have the disease given a positive test?)
* $P(B|A)$ is the probability of B given A (i.e., how likely is the test to be positive when the disease is present)
    * this is the probability of a "true positive"
	* for disease tests this is called the **sensitivity**
* P(B|A<sup>c</sup>) is probability of B in the absence of A (i.e. how likely are we to have the disease when the test is false)* P(B<sup>c</sup>|A<sup>c</sup>) is probability of not B in the absence of A (i.e. how likely are we to not have the disease when the test is false)
    * this is the probability of a "true negative"
	* for disease tests this is called the **sensitivity**

* P(A) is the prevalence, or probability of the condition in the population (given no other information)

P(A|B) = P(B|A)P(A) / P(B) = P(B|A) P(A)/ ( P(B|A) P(A) + P(B|A<sup>c</sup>) P(A<sup>c</sup>))


P(A|B) = P(B|A) P(A)/ ( P(B|A) P(A) + (1- P(B<sup>c</sup>|A<sup>c</sup>)) (1-P(A)))
