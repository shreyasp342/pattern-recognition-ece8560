function x = pca1(H,St,dim)
C = 3;
m = mean(H);
H1 = bsxfun(@minus, H,m);
sigmaY = cov(H1);
[~,Z] = eig(sigmaY);
[~,i] = sort(diag(Z),'descend');
H3 = bsxfun(@plus, H1(:,i(1:dim)), m(i(1:dim)));
St2 = St(:,i(1:dim));
x = bayesian(H3,St2,C);
end