clear all

fp = fopen('train_sp2017_v19');
A = textscan(fp,'%f%f%f%f');
[~] = fclose(fp);
for i = 1:size(A,2)
H(:,i) = A{1,i}(1:end, :);
end
clear A fp

fp = fopen('test_sp2017_v19');
A = textscan(fp,'%f%f%f%f');
[~] = fclose(fp);
for i = 1:size(A,2)
S(:,i) = A{1,i}(1:end, :);
end
clear A fp

trueClass =[];
trueSequ = [3, 1, 2, 3, 2, 1];
for i = 1 : 15000/6
    trueClass = [trueClass, trueSequ];
end

dataTrain = H(1:10000,:);
labelTrain = [ones(1,5000), ones(1,5000)*2]';
dataTest = S(trueClass == 1 | trueClass == 2,:);
labelTest = trueClass(trueClass == 1 | trueClass == 2);
labelTest = labelTest';
clear S H trueClass trueSequ i

%Scaling
dataTrain1 = dataTrain;
dataTest1 = dataTest;
maxi = max(dataTrain1);
mini = min(dataTrain1);
mi = maxi-mini;
dataTrain = (dataTrain1-mini)./mi;
dataTest = (dataTest1-mini)./mi;

%Grid search - Stage 1 
tic;
ci = -10:2:20;
cvc = [];
parfor i = 1:length(ci)
    c = 2^ci(i);
    fprintf("i=%d\tc=%f\n",i,ci(i));
    k = strcat({'-t 0 -v 5'},{' -c '}, {num2str(c)});
    cvc(i) = svmtrain(labelTrain, dataTrain, k{1,1});
end
toc;

[~,cin] = max(cvc);
c1 = ci(cin);

%Grid search - Stage 2
tic;
ci = c1-2:0.5:c1+2;cvc = [];
parfor i = 1:length(ci)
    c = 2^ci(i);
    fprintf("i=%d\tc=%f\n",i,ci(i));
    k = strcat({'-t 0 -v 5'},{' -c '}, {num2str(c)});
    cvc(i) = svmtrain(labelTrain, dataTrain, k{1,1});
end
toc;

[~,cin] = max(cvc);
c2 = ci(cin);

%Grid search - Stage 3
tic;
ci = c2-0.5:0.1:c2+0.5;
cvc = [];
parfor i = 1:length(ci)
    c = 2^ci(i);
    fprintf("i=%d\tc=%f\n",i,ci(i));
    k = strcat({'-t 0 -v 5'},{' -c '}, {num2str(c)});
    cvc(i) = svmtrain(labelTrain, dataTrain, k{1,1});
end
toc;

[~,cin] = max(cvc);
c3 = ci(cin);
c = c3;

k = strcat({'-t 0'},{' -c '},{num2str(2^c)});
model = svmtrain(labelTrain, dataTrain, k{1,1});
[predict_label, accuracy, dec_values] = svmpredict(labelTest, dataTest, model);

%Hyperplane paramenter
w = (model.sv_coef' * full(model.SVs));
b = -model.rho;

sv = full(model.SVs);
fx = fopen('linear.sv', 'wt');
for i = 1 : size(sv,1)
    fprintf(fx, '%f\t%f\t%f\t%f\n', sv(i,1), sv(i,2), sv(i,3), sv(i,4));
end
[~] = fclose(fx);