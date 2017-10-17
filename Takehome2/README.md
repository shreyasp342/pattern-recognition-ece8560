# ECE 8560 Pattern Recogition

3 class, d=4 dimensions 15000 samples testing data and 15000 samples training data

The first 5000 samples in training data H (train_sp2017_v19) correspond to class w1 (H1), the second 5000 samples correspond to class w2 (H2) and the third 5000 samples correspond to class w3 (H3).

the true class sequence of ST (test_sp2017_v19) is 3-1-2-3-2-1, which repeats throughout ST.


## Takehome 2
### Ho-Kashyap Hyperplanar Classifier

The Confusion Matrix is

| N = 15000           | class 1 (predicted)  | class 2 (predicted)  | class 3 (predicted)  |
| ------------------- |:--------------------:|:--------------------:|:--------------------:|
| **class 1 (true)**  | 4915                 | 582                  | 223                  |
| **class 2 (true)**  | 1283                 | 3717                 | 0                    |
| **class 3 (true)**  | 739                  | 17                   | 4244                 | 

Error was found to be **18.96%**

### k-Nearest Neighbour

#### k = 1

The Confusion Matrix is

| N = 15000           | class 1 (predicted)  | class 2 (predicted)  | class 3 (predicted)  |
| ------------------- |:--------------------:|:--------------------:|:--------------------:|
| **class 1 (true)**  | 4101                 | 631                  | 268                  |
| **class 2 (true)**  | 654                  | 4284                 | 82                   |
| **class 3 (true)**  | 289                  | 63                   | 4648                 | 

Error was found to be **13.25%**

#### k = 3

The Confusion Matrix is

| N = 15000           | class 1 (predicted)  | class 2 (predicted)  | class 3 (predicted)  |
| ------------------- |:--------------------:|:--------------------:|:--------------------:|
| **class 1 (true)**  | 4283                 | 491                  | 226                  |
| **class 2 (true)**  | 626                  | 4311                 | 63                   |
| **class 3 (true)**  | 247                  | 54                   | 4699                 | 

Error was found to be **11.38%**

#### k = 5

The Confusion Matrix is

| N = 15000           | class 1 (predicted)  | class 2 (predicted)  | class 3 (predicted)  |
| ------------------- |:--------------------:|:--------------------:|:--------------------:|
| **class 1 (true)**  | 4351                 | 432                  | 217                  |
| **class 2 (true)**  | 532                  | 4352                 | 56                   |
| **class 3 (true)**  | 235                  | 51                   | 4714                 | 

Error was found to be **10.55%**


### Princpile Component Analysis (PCA)

The Confusion Matrix is

| N = 15000           | class 1 (predicted)  | class 2 (predicted)  | class 3 (predicted)  |
| ------------------- |:--------------------:|:--------------------:|:--------------------:|
| **class 1 (true)**  | 4606                 | 273                  | 123                  |
| **class 2 (true)**  | 1608                 | 3392                 | 0                    |
| **class 3 (true)**  | 640                  | 0                    | 4360                 | 

Error was found to be **17.63%**

#### Comparison and Analysis of classifiers
P(error)

| Classifier 						 | P(error) (%) |
| ---------------------------------- | ------------:|
| Bayesian Classifier                | 94.0% 		|
| Ho-Kashyap Hyperplane Classifier   | 18.96% 		|
| 1-NNR                              | 13.25% 		|
| 3-NNR							     | 11.38% 		|
| 5-NNR							     | 10.55% 		|
| Principle Component Analysis (PCA) | 17.63% 		|

