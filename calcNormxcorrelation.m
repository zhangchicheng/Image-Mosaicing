function cor = calcNormxcorrelation( A, B )
% Compute normalized cross-correlation
%   Input:
%       A, B - feature vector m*p and n*p
%   Output:
%       cor - m*n

    m = size(A,1);
    n = size(B,1);
    foo = sum(A.^2, 2);
    bar = sum(B.^2, 2);
    cor = zeros(m, n);
    for i = 1:m
        for j = 1:n
            cor(i, j) = sum(A(i,:).*B(j,:))/sqrt(foo(i) * bar(j));
        end
    end

end

