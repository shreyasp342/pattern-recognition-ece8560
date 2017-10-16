function x = knnDecision(nnr)
    order = [1, 2, 3];
    counts = [sum(nnr==1), sum(nnr==2), sum(nnr==3)];
    [maxi, ii] = max(counts);
    if sum(counts == maxi)>1
        ti = order(counts == maxi);
        ty = logical(zeros(1,length(nnr)));
        for f = 1: length(ti)
            ty = ty | (nnr==ti(f));
        end
        x = nnr(find(ty,1));
    else
        x = ii;
    end