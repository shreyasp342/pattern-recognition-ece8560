clear all

c = 2;
for c = 2:5
fp = fopen('train_sp2017_v19');
A = textscan(fp,'%f%f%f%f');
[~] = fclose(fp);
for i = 1:size(A,2)
H(:,i) = A{1,i}(1:end, :);
end
clear A fp

%Euclidean distance
mu = initMu(c,H);
mu1 = mu;
while true 
    y = pdist2(H,mu,'euclidean');
    [~,ind] = min(y,[],2);
    for i = 1:c
        mu1(i,:) = mean(H(ind == i,:));
    end
    if mu1 == mu
        break
    else
        mu = mu1;
    end
end
ce(:,c)=ind;
for i = 1:c
    counte(i,c) = sum(ind==i);
end

%Cityblock distance
mu = initMu(c,H);
mu1 = mu;
while true 
    y = pdist2(H,mu,'cityblock');
    [~,ind] = min(y,[],2);
    for i = 1:c
        mu1(i,:) = mean(H(ind == i,:));
    end
    if mu1 == mu
        break
    else
        mu = mu1;
    end
end
cc(:,c)=ind;
for i = 1:c
    countc(i,c) = sum(ind==i);
end
end
for c = 2:5
    fname = strcat('euclidean-c',num2str(c),'.txt');
    fx = fopen(fname, 'wt');
    for i = 1 : size(ce,1)
        fprintf(fx, '%d\n', ce(i,c));
    end
    [~] = fclose(fx);
    
    fname = strcat('cityblock-c',num2str(c),'.txt');
    fx = fopen(fname, 'wt');
    for i = 1 : size(ce,1)
        fprintf(fx, '%d\n', cc(i,c));
    end
    [~] = fclose(fx);
end
