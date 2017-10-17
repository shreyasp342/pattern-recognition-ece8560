# ECE 8560 Pattern Recogition

3 class, d=4 dimensions 15000 samples testing data and 15000 samples training data

The first 5000 samples in training data H (train_sp2017_v19) correspond to class w1 (H1), the second 5000 samples correspond to class w2 (H2) and the third 5000 samples correspond to class w3 (H3).

the true class sequence of ST (test_sp2017_v19) is 3-1-2-3-2-1, which repeats throughout ST.

## Takehome 1
### Bayesian Estimation

The Confusion Matrix is

| N = 15000           | class 1 (predicted)  | class 2 (predicted)  | class 3 (predicted)  |
| ------------------- |:--------------------:|:--------------------:|:--------------------:|
| **class 1 (true)**  | 4218                 | 547                  | 235                  |
| **class 2 (true)**  | 395                  | 4568                 | 37                   |
| **class 3 (true)**  | 148                  | 48                   | 4804                 | 

Error was found to be **9.40%**

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


## Takehome 3
### Support Vector Machines (SVM)
We are asked to use the first two classes of the training set to train the SVM model and then discriminate between the first two classes in the test set.

I used a software package called **LIBSVM** for the implementation of SVM.

#### Linear Kernel
The implementation of Linear Kernel SVM using **LIBSVM**
<p>
<ol>
<li> Scale the training data and reduce the range to [0,1] using min-max formulation.</li>
<li> Find the penalty parameter, C using k-fold cross-validation and grid search.</br>
	I used k=5 for cross validation, and for grid search. In grid search, C is searched in the exponential search space, to cover a wider area. To fine tune the calculation of C, I implemented grid search in 3 stages. <br>
	C is calculated as <b>C = 2^p</b><br>
	I used p in the range [-10, 20] with increment steps of 2. After getting a coarse-value C1 at corresponding p1, I ran for p in the range[p1-2, p1+2] with increment steps of 0.5, to find C2 and p2. Finally, I ran for C in the range [p2-0.5, p2+0.5] with step increments of 0.1. This helps get finely tuned value for C using grid-search with reduced computation time. <br>
	For the given training set, <b>C</b> is found to be <b>9.2681x104</b> and <b>p</b> is <b>16.5</b>.</li>
<li> Train the SVM and generate the model parameters using the MATLAB function,<br>
	 <b><em>model = svmtrain(label,trainingdata,expression);</em></b><br>
		where,
			<ol>trainingdata – mXn matrix with m vectors and each vector has n features</ol>
		    <ol> label – mX1 matrx where each rows is the label (class) of the corresponding vector in training set.</ol>
		    <ol>expression – LIBSVM parameter option string. We use <b>-t 0 -c 9.2681x104 </b></ol></li>
<li> Test SVM on the testing data and check the accuracy of the model using the MATLAB function,<br>
	 <b><em>[predictedlabel, accuracy, decision_values] = svmpredict(testinglabel, testingdata, model);</em></b><br>
		where,
			<ol>testingdata – mXn matrix with m vectors and each vector has n features.<br>
		    <ol>label – mX1 matrx where each row is the label (class) of the corresponding vector in testing set. This is used for finding the accuracy.</ol>
		    <ol>model – output from previous step.</ol>
		    <ol>predictedlabel – the predicted class for each row in testingdata</ol>
		    <ol>accuracy – accuracy of the system</ol></li>
<li> Hyperplane parameter is calculated using<br>
	 <b><em>w = wc * SV</em></b><br>
		where,
			<ol>wc – nX1 coefficient vector (<b>model.sv_coef'</b>)</ol>
		    <ol>SV – mXn support vectors (<b>model.SVs</b>)</ol></li>
</ol>
</p>

For the given data with **C = 9.2681x(10^4)**, we got **4520** support vectors.

The accuracy was found to be **81.49%**

