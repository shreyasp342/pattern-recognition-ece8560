function A = confMat(predicted,trueVal)
n = length(trueVal);
c = max(trueVal);
A = zeros(c,c);
for i = 0:length(predicted)-1
    A(trueVal(mod(i,n)+1), predicted(i+1)) = A(trueVal(mod(i,n)+1), predicted(i+1)) + 1;
end
end