function [C,V,A,E,w] = cmatrix(varargin)
% [C,V,A,E,w] = CMATRIX(LEARN,K,TEST)
%
% Used by YKR

% $Revision: 1.1 $ $Date: 2004-09-06 09:00:12+02 $ $Author: tgebbie $

switch nargin
case 4
    x = varargin{1};
    k = varargin{2};
    t = varargin{3};
    order = varargin{4};
    a = [];
case 5
    x = varargin{1};
    k = varargin{2};
    t = varargin{3};
    order = varargin{4};
    a = varargin{5};
otherwise
    error('Incorrect Input Arguments');
end

% get the i-th row of weight weights
w = wfunc(x,k,t,a);
% if the first column is the time index
if nargin==5 & ~isempty(a)
  tt = t(:,1); t = t(:,2:end);
  tx = x(:,1); t = t(:,2:end);
end
% get the size of w
[m,n]=size(w);
% get the dependent (range) and independent (domain)
y = x(:,end); x = x(:,1:end-1);
% initialize g
g = gfunc(x,order);
% get the size of g
[mg,ng] = size(g);

% find the C and V matrix and vector
for j=1:n %% across test points
    % initialize C
    C(:,:,j) = zeros(mg);
    % initialize V
    V(:,j) = zeros(mg,1);
 for i=1:m %% sum across learning points
    % get the C matrix
    C(:,:,j) = (g(:,i)*g(:,i)') * w(i,j) + C(:,:,j);
    % get the V vector
    V(:,j) = g(:,i) * w(i,j) * y(i) + V(:,j);
 end
    % solve the least square problem
    A(:,j)=C(:,:,j) \ V(:,j);
end

% generate the error weight vector
for j=1:n %% across test points
  for i=1:m %% across learning points  
     E(:,j) = g(:,i)' * inv(C(:,:,j)) * g(:,i);
  end
end
      
% if a vector or matrix reshape
[i,j,k]=size(C);
if i==1 & j==1
  C=reshape(C,k,i,j);
elseif i==1 
  C=reshape(C,j,k,i);
elseif j==1
  C=reshape(C,k,i,j);
end