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
	I used <b>k=5</b> for cross validation, and for grid search. In grid search, C is searched in the exponential search space, to cover a wider area. To fine tune the calculation of C, I implemented grid search in 3 stages. <br>
	C is calculated as <b>C = 2^p</b><br>
	I used p in the range [-10, 20] with increment steps of 2. After getting a coarse-value C1 at corresponding p1, I ran for p in the range[p1-2, p1+2] with increment steps of 0.5, to find C2 and p2. Finally, I ran for C in the range [p2-0.5, p2+0.5] with step increments of 0.1. This helps get finely tuned value for C using grid-search with reduced computation time. <br>
	For the given training set, <b>C</b> is found to be <b>9.2681x(10^4)</b> and <b>p</b> is <b>16.5</b>.</li>
<li> Train the SVM and generate the model parameters using the MATLAB function,<br>
	 <b><em>model = svmtrain(label,trainingdata,expression);</em></b><br>
		where,
			<ol><em>trainingdata</em> – mXn matrix with m vectors and each vector has n features.</ol>
		    <ol><em>label</em> – mX1 matrx where each rows is the label (class) of the corresponding vector in training set.</ol>
		    <ol><em>expression</em> – LIBSVM parameter option string. We use <b>-t 0 -c 9.2681x104 </b>.</ol></li>
<li> Test SVM on the testing data and check the accuracy of the model using the MATLAB function,<br>
	 <b><em>[predictedlabel, accuracy, decision_values] = svmpredict(testinglabel, testingdata, model);</em></b><br>
		where,
			<ol><em>testingdata</em> – mXn matrix with m vectors and each vector has n features.</ol>
		    <ol><em>label</em> – mX1 matrx where each row is the label (class) of the corresponding vector in testing set. This is used for finding the accuracy.</ol>
		    <ol><em>model</em> – output from previous step.</ol>
		    <ol><em>predictedlabel</em> – the predicted class for each row in <em>testingdata</em>.</ol>
		    <ol><em>accuracy</em> – accuracy of the system.</ol></li>
<li> Hyperplane parameter is calculated using<br>
	 <b><em>w = wc * SV</em></b><br>
		where,
			<ol><em>wc</em> – nX1 coefficient vector (<b>model.sv_coef'</b>).</ol>
		    <ol><em>SV</em> – mXn support vectors (<b>model.SVs</b>).</ol></li>
</ol>
</p>

For the given data with **C = 9.2681x(10^4)**, we got **4520** support vectors.

The accuracy was found to be **81.49%**

#### Radio Basis Function (RBF) Kernel
The implementation of RBF Kernel SVM using **LIBSVM**
<p>
<ol>
<li> Scale the training data and reduce the range to [0,1] using min-max formulation.</li>
<li> Find the penalty parameter, C and the kernel parameter, <em>gamma</em> using k-fold cross-validation and grid search.</br>
	I used <b>k=5</b> for cross validation, and for grid search. In grid search, C is searched in the exponential search space, to cover a wider area. To fine tune the calculation of C, I implemented grid search in 3 stages. <br>
	C is calculated as <b>C = 2^p</b> and <b>gamma = 2^q</b><br>
	I used p in the range [-10, 20] with increment steps of 2. After getting a coarse-value C1 at corresponding p1, I ran for p in the range[p1-2, p1+2] with increment steps of 0.5, to find C2 and p2. Finally, I ran for C in the range [p2-0.5, p2+0.5] with step increments of 0.1. This helps get finely tuned value for C using grid-search with reduced computation time. q is run in the range [10,10] for all C, to find gamma.<br>
	For the given training set, <b>C</b> is found to be <b>1.6635x(10^4)</b> at <b>p</b> is <b>16.5</b> and <b>gamma</b> is found to be <b>1.1487</b> at <b>q</b> is <b>0.2</b>.</li>
<li> Train the SVM and generate the model parameters using the MATLAB function,<br>
	 <b><em>model = svmtrain(label,trainingdata,expression);</em></b><br>
		where,
			<ol><em>trainingdata</em> – mXn matrix with m vectors and each vector has n features.</ol>
		    <ol><em>label</em> – mX1 matrx where each rows is the label (class) of the corresponding vector in training set.</ol>
		    <ol><em>expression</em> – LIBSVM parameter option string. We use <b>-t 0 -g 1.1487 -c 1.6635x10^4 </b>.</ol></li>
<li> Test SVM on the testing data and check the accuracy of the model using the MATLAB function,<br>
	 <b><em>[predictedlabel, accuracy, decision_values] = svmpredict(testinglabel, testingdata, model);</em></b><br>
		where,
			<ol><em>testingdata</em> – mXn matrix with m vectors and each vector has n features.</ol>
		    <ol><em>label</em> – mX1 matrx where each row is the label (class) of the corresponding vector in testing set. This is used for finding the accuracy.</ol>
		    <ol><em>model</em> – output from previous step.</ol>
		    <ol><em>predictedlabel</em> – the predicted class for each row in <em>testingdata</em>.</ol>
		    <ol><em>accuracy</em> – accuracy of the system.</ol></li>
<li> Hyperplane parameter is calculated using<br>
	 <b><em>w = wc * SV</em></b><br>
		where,
			<ol><em>wc</em> – nX1 coefficient vector (<b>model.sv_coef'</b>).</ol>
		    <ol><em>SV</em> – mXn support vectors (<b>model.SVs</b>).</ol></li>
</ol>
</p>

For the given data with **C = 1.6635x(10^4)** and **gamma = 1.1487**, we got **2179** support vectors.

The accuracy was found to be **90.86%**

### crisp c-means

Find the c-means cluster for c = 2,3,4,5.

<p>
Crisp c-means Algorithm
<ol>
	<li> Choose the number of clusters <em>c</em>. Here c = 2,3,4,5.</li>
	<li> Choose m1, m2, ..., mc initial guesses of centroid.</li>
	<li> Classify each xk in the given data set.</li>
	<li> Recompute the estimates for mi, using results in step 3.</li>
	<li> If <em>mi</em> are consistent i.e., if it is the same as the previous iteration, then STOP.</li>
	<li> Else, go to step 3.</li>
</ol>
<br>
<ol>
	<li> Find mean <em>m</em> and variance <em>V</em> of the data set.</li>
	<li> Calculate the eigen values of the variance <em>V</em>.</li>
	<li> We consider the feature in the dataset that has the maximum variance, i.e., the feature corresponding to the largest eigen values.</li>
	<li> Split the data set into 2 clusters <em>c1</em> and <em>c2</em>, based on whether the data point is to the left or right of the mean of the feature selected in step 3.</li>
	<li> Calculate the centroid (mean) of c1 and c2. If c=2, c1 and c2 are the required centroids.</li>
	<li> If c=3, take the average of the centroids of c1 and c2 to find the centroid c3. c1, c2 and c3 are the required centroids.</li>
	<li> Else if c=4 or c=5, split the cluster c1 to get c11,c12 and cluster c2 to get c21,c22 using steps 3, 4, and 5.</li>
	<li> Calculate the centroids of c11, c12, c21, c22. If c=4, c11, c12, c21, and c22 are the required centroid</li>
	<li> If c=5, take the average of the centroid c11, c12, c21, c22 to find c5. c11, c12, c21, c22 and c5 are the required centroids.</li>
</ol>
<br>
The 2 distance measures that I have used are:
<ol>
	<li> Euclidean Distance. </li>
	<li> Cityblock Distance. </li>
</ol>
</p>

The number of data points in cluster are --

Euclidean Distance

|        | c = 2 | c = 3 | c = 4 | c = 5 |
| -------|:-----:|:-----:|:-----:|:-----:|
| **c1** | 11199 | 3002  | 7347  | 2096  |
| **c2** | 3801  | 3528  | 2891  | 2305  |
| **c3** | NA    | 8470  | 2090  | 2047  |
| **c4** | NA    | NA    | 2672  | 2365  |
| **c5** | NA    | NA    | NA    | 6187  |
	
Cityblock Distance

|        | c = 2 | c = 3 | c = 4 | c = 5 |
| -------|:-----:|:-----:|:-----:|:-----:|
| **c1** | 10369 | 4000  | 2204  | 2019  |
| **c2** | 4631  | 3401  | 2422  | 2317  |
| **c3** | NA    | 7599  | 2847  | 2092  |
| **c4** | NA    | NA    | 7527  | 2316  |
| **c5** | NA    | NA    | NA    | 6256  |

For c = 3, 

The mean values are

|        | c = 2   | c = 3    | c = 4    | c = 5    |
| -------|:-------:|:--------:|:--------:|:--------:|
| **c1** | 48.5887 | 36.2621  | 29.6554  | -49.9104 |
| **c2** | 8.6363  | 1.0523   | -25.1384 | 16.1527  |
| **c3** | 52.3518 | -13.1060 | -14.9808 | -47.7503 |

The mean values of the classes w1, w2 and w3 of the training set are

|        | c = 2   | c = 3    | c = 4    | c = 5    |
| -------|:-------:|:--------:|:--------:|:--------:|
| **c1** | 50.1171 | -4.9704  | -24.8118 | -49.8120 |
| **c2** | 24.1311 | -0.1184  | -25.0483 | 0.2945   |
| **c3** | 49.7022 | 5.4015   | 24.5501  | -49.9373 |

The means of cmeans for c = 3 and means of classes w1, w2, w3 are somewhat comparable.

c1, c2, and c3 are close to w3, w2, and w1 respectively.

	