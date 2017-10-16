clear all

C = 3;

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
St(:,i) = A{1,i}(1:end, :);
end
clear A fp

trueVal = [3, 1, 2, 3, 2, 1];
fp = fopen('sprabha-classified-takehome1.txt');
A = textscan(fp,'%d');
[~] = fclose(fp);
predicted = A{1,1};
clear A fp

conf1 = confMat(predicted, trueVal);
x = pca1(H,St,2);
fx = fopen('sprabha-classified-pca.txt', 'wt');
for i = 1 : length(x)
        fprintf(fx, '%d\n', x(i));
end
[~] = fclose(fx);
confPCA = confMat(x,trueVal);

y = hoKashyap(H,St,1);
confHoK = confMat(y, trueVal);
fx = fopen('sprabha-classified-hoKayshap.txt', 'wt');
for i = 1 : length(y)
        fprintf(fx, '%d\n', y(i));
end
[~] = fclose(fx);

[x1,x3,x5] = kNNR1(H, St);
confNNR1 = confMat(x1, trueVal);
confNNR3 = confMat(x3, trueVal);
confNNR5 = confMat(x5, trueVal);
fx = fopen('sprabha-classified-nnr1.txt', 'wt');
fy = fopen('sprabha-classified-nn3.txt', 'wt');
fz = fopen('sprabha-classified-nnr5.txt', 'wt');
for i = 1 : length(x1)
        fprintf(fx, '%d\n', x1(i));
        fprintf(fy, '%d\n', x3(i));
        fprintf(fz, '%d\n', x5(i));
end
[~] = fclose(fx);
[~] = fclose(fy);
[~] = fclose(fz);