function mui = initMu(c,H)
mu = mean(H);
var = cov(H);
[~,D]= eig(var);
[~,dim] = max(diag(D));
H1 = H;
cc = [1 1];
for i = 1:size(H1,1)
    if H1(i,dim) <= mu(dim)
        C{1}(cc(1),:) = H1(i,:);
        cc(1) = cc(1) + 1;
    else
        C{2}(cc(2),:) = H1(i,:);
        cc(2) = cc(2) + 1;
    end
end
if c==2 || c==3
    mui(1,:) = mean(C{1});
    mui(2,:) = mean(C{2});
    if c == 3
        mui(3,:) = (mean(C{1})+mean(C{2}))/2;
    end
elseif c==4 || c==5
    C1 = C;
    clear C
    H1 = C1{1};
    cc = [1 1];
    mu = mean(H1);
    var = cov(H1);
    [~,dim] = max(diag(var));
    for i = 1:size(H1,1)
        if H1(i,dim) <= mu(dim)
            C{1}(cc(1),:) = H1(i,:);
            cc(1) = cc(1) + 1;
        else
            C{2}(cc(2),:) = H1(i,:);
            cc(2) = cc(2) + 1;
        end
    end
    cc = [1 1];
    H1 = C1{2};
    mu = mean(H1);
    var = cov(H1);
    [~,dim] = max(diag(var));
    for i = 1:size(H1,1)
        if H1(i,dim) <= mu(dim)
            C{3}(cc(1),:) = H1(i,:);
            cc(1) = cc(1) + 1;
        else
            C{4}(cc(2),:) = H1(i,:);
            cc(2) = cc(2) + 1;
        end
    end
    mui(1,:) = mean(C{1});
    mui(2,:) = mean(C{2});
    mui(3,:) = mean(C{3});
    mui(4,:) = mean(C{4});
    if c == 5
        mui(5,:) = (mean(C{1})+mean(C{2})+mean(C{3})+mean(C{4}))/4;
    end
end
        