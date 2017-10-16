function [x1,x3,x5] = kNNR1(H, St)
for i = 1 : size(St,1)
    cc = (bsxfun(@minus,H,St(i,:))).^2;
    disti = sqrt(sum(cc,2));
    [~,ind] = sort(disti);
    nnr5 = ind(1:5);
    for j = 1:5
        if nnr5(j) <= 5000
            nnr5Class(j) = 1;
        elseif nnr5(j) <= 10000
            nnr5Class(j) = 2;
        else
            nnr5Class(j) = 3;
        end
    end
    x5(i) = knnDecision(nnr5Class);
    x3(i) = knnDecision(nnr5Class(1:3));
    x1(i) = nnr5Class(1);
end
end