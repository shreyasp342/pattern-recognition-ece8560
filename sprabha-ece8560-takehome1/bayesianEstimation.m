clear all

fp = fopen('train_sp2017_v19');
A = textscan(fp,'%f%f%f%f');
[~] = fclose(fp);

dim = size(A,2);
totalSize = size(A{1,1},1);
C = 3;
sizeC = totalSize/3;
N = 0.9 * sizeC;
for i = 1:dim
H(:,i) = A{1,i}(1:end, :);
end
clear A fp

for i = 1:C
    starting = ((i-1)*sizeC)+1;
    ending = ((i-1)*sizeC)+N;
    w{1,i} = H(starting:ending,:);
end
clear starting ending
 
%Maximum Likelihood Estimation
for i = 1:C
MLEm{1,i} = sum(w{1,i})/N;
MLEc{1,i} = cov(w{1,i});
end

sig0 = eye(dim);
mu0 = zeros(1,dim)';

% Bayesian Parameter Estimation
for i = 1:C
   b = (1/N) * MLEc{1,i};
   a = inv(sig0 + b);
   sign{1,i} = sig0 * a * b;
   mu{1,i} = ((sig0 * a * MLEm{1,i}') + (b * a * mu0))';
end
clear a b

%Classifying the test data
ftest = fopen('train_sp2017_v19');
A = textscan(ftest,'%f%f%f%f');
[~] = fclose(ftest);

for i = 1:dim
xi(:,i) = A{1,i}(1:end, :);
end

clear ftest A

%Discriminant Function g(i)
for i = 1 : size(xi, 1)
    for j = 1 : C
        mahal_dist = ((xi(i,:)-mu{1,j}) * inv(sign{1,j}) * (xi(i,:)-mu{1,j})');
        logc = log(det(sign{1,j}));
        g(i,j) = -(1/2) * (mahal_dist + logc);
    end
    
    if ((g(i, 1) >= g(i, 2)) && (g(i, 1) >= g(i, 3)))
        predict(i) = 1;
    elseif ((g(i, 2) >= g(i, 1)) && (g(i, 2) >= g(i, 3)))
        predict(i) = 2;
    else
        predict(i) = 3;
    end
end

fx = fopen('x.dat', 'w');
for i = 1 : length(predict)
        fprintf(fx, '%d\n', predict(i));
end
[~] = fclose(fx);