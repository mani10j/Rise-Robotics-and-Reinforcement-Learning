function g=gfunc(x,order)
% G=GFUNC(X,ORDER) define the g-function for 1/2 order algorithm
%
% Used by YKR

% $Revision: 1.1 $ $Date: 2004-09-06 09:00:12+02 $ $Author: tgebbie $

% get the length and width
[m,n]=size(x);

    % the constant
    g=ones(1,m);
    % flip the data
    x = x';

switch order
case 0
case 1
    % the vector part
    g=[g; x];
case 2
    % the vector part
    g=[g; x];
    for i = 1:m
     % matrix part
     M = x(:,i) * x(:,i)';
     % index
     p = length(M); k =[];
     % generate the lower triangular index
     for j=1:p, a = ((j-1)*p+j:j*p); k = [k a]; end;
     % the vectorization of the matrix
     z = M(k);
     % add on to function
     y(:,i) = z(:);
    end 
    g = [g; y];
otherwise
    error('Unsupported Order');
end
