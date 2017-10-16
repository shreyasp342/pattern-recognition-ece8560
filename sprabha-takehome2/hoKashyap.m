function x = hoKashyap(Hi,St,alp)
C = 3;
nC = size(Hi,1);
dim = size(Hi,2);
Hi(:,dim+1) = ones(1,nC);
St(:,dim+1) = ones(1,nC);
nC = nC/C;
for i = 0 : C-1
    J{1,i+1} = Hi((i*nC)+1: (i+1)*nC, :);
end

a = 1;
for i = 1:C
    for j = i+1:C
        k = 0;
        A = [J{1,i};-J{1,j}];
        AA = [J{1,i};J{1,j}];
        b = ones(size(A,1),1);
        w = inv(A'*A)*A'*b;
        while true
            e = A*w-b;
            b1 = b + alp*(e+abs(e));
            w = inv(A'*A)*A'*b;
            if k>100 | e>=0 | b1==b
                break;
            else
                b = b1;
            end
            k = k + 1;
        end
        omega{1,a} = w;
        a = a+1;
    end
end

for t = 1 : size(St,1)
    g1 = omega{1,1}'*St(t,:)';
    g2 = omega{1,2}'*St(t,:)';
    g3 = omega{1,3}'*St(t,:)';
    if g1 > 0 && g2 > 0
        x(t) = 1;
    elseif g1<0 && g3>0
        x(t) = 2;
    else
        x(t) = 3;
end
end