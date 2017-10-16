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

dataTrain1 = dataTrain;
dataTest1 = dataTest;
maxi = max(dataTrain1);
mini = min(dataTrain1);
mi = maxi-mini;
dataTrain = (dataTrain1-mini)./mi;
dataTest = (dataTest1-mini)./mi;

%Grid search - Stage 1 
tic;
gi = -10:2:10;
ci = -10:2:10;
cvc = [];
for i = 1:length(ci)
    c = 2^ci(i);
    cv = [];
    parfor j = 1:length(gi)
        g = 2^gi(j);
        fprintf("i = %d\t j = %d\t c=%f\tg=%f\n",i,j,ci(i),gi(j));
        k = strcat({'-t 2 -v 5 -g '},{num2str(g)},{' -c '}, {num2str(c)});
        cv(j) = svmtrain(labelTrain, dataTrain, k{1,1});
    end
    cvc(i,:) = cv; 
end
toc;

[m,cii] = max(cvc);
[~,gval] = max(m);
cval = cii(gval);
c1 = ci(cval);
g1 = gi(gval);

%Grid search - Stage 2
tic;
gi = g1-2:0.5:g1+2;
ci = c1-2:0.5:c1+2;
cvc = [];
for i = 1:length(ci)
    c = 2^ci(i);
    cv = [];
    parfor j = 1:length(gi)
        g = 2^gi(j);
        fprintf("i = %d\t j = %d\t c=%f\tg=%f\n",i,j,ci(i),gi(j));
        k = strcat({'-t 2 -v 5 -g '},{num2str(g)},{' -c '}, {num2str(c)});
        cv(j) = svmtrain(labelTrain, dataTrain, k{1,1});
    end
    cvc(i,:) = cv; 
end
toc;

[m,cii] = max(cvc);
[~,gval] = max(m);
cval = cii(gval);
c2 = ci(cval);
g2 = gi(gval);

%Grid search - Stage 3 
tic;
gi = g2-0.5:0.1:g2+0.5;
ci = c2-0.5:0.1:c2+0.5;
cvc = [];
for i = 1:length(ci)
    c = 2^ci(i);
    cv = [];
    parfor j = 1:length(gi)
        g = 2^gi(j);
        fprintf("i = %d\t j = %d\t c=%f\tg=%f\n",i,j,ci(i),gi(j));
        k = strcat({'-t 2 -v 5 -g '},{num2str(g)},{' -c '}, {num2str(c)});
        cv(j) = svmtrain(labelTrain, dataTrain, k{1,1});
    end
    cvc(i,:) = cv; 
end
toc;

[m,cii] = max(cvc);
[~,gval] = max(m);
cval = cii(gval);
c3 = ci(cval);
g3 = gi(gval);

c = c3;
g = g3;

k = strcat({'-t 2 -g '},{num2str(2^g)},{' -c '}, {num2str(2^c)});
model = svmtrain(labelTrain, dataTrain, k{1,1});
[predict_label, accuracy, dec_values] = svmpredict(labelTest, dataTest, model);

%Hyperplane paramenter
w = (model.sv_coef' * full(model.SVs));
b = -model.rho;

sv = full(model.SVs);
fx = fopen('rbf.sv', 'wt');
for i = 1 : size(sv,1)
    fprintf(fx, '%f\t%f\t%f\t%f\n', sv(i,1), sv(i,2), sv(i,3), sv(i,4));
end
[~] = fclose(fx);