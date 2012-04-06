function [y, vr, A] = ykr(varargin)
% [Y, VR] = YKR(x,k,t,order,h)
%
% x - learn independent
% k - dispersion 
% t - test
% h - half-life : if included the first columns of x, t is treated as time.
%
% h allows the exponential forgetting of information
%
% order 0,1,2
%
% Input:
% ------
%               X   Y
%  LEARN =      1   12.00
%               3   18.00
%               5   20.00
%               7   17.00
%
%  TEST  =      2   14.00
%               4   18.50
%               6   19.00
% 
%  [Y, VR] = YKR(LEARN,1,TEST,1) : for example 2
%
%         +----------------+----------------+----------------+
%         | Ex. 1: Order-0 | Ex. 2: Order-1 | Ex. 3: Order-2 |
%         +----------------+----------------+----------------+
%  k      | 0.1            | 1              | 1              |
%  order  | 0              | 1              | 2              |
%         +----------------+----------------+----------------+
%         | X    Y         | X    Y         | X   Y          |
%  Y      | 2    15.96     | 2    14.999    | 2   15.500     |
%         | 4    17.61     | 4    18.996    | 4   19.563     |
%         | 6    18.18     | 6    18.499    | 6   19.125     |
%         + ---------------+----------------+----------------+
%  VR     | 65.05 %        | 90.12 %        | 77.62 %        |     
%         +----------------+----------------+----------------+ 
% 
% See: wfunc.m

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

% get the constants
[C,V,A,E,w] = cmatrix(x,k,t,order,a);
% if the first column is the time index
if nargin==5 & ~isempty(a)
  tt = t(:,1); t = t(:,2:end);
  tx = x(:,1); t = t(:,2:end);
end
% get the domain part
tx = t(:,1:end-1);
% get the g functions
g = gfunc(tx,order);
% find the fit
y = diag(g' * A);

% variance reduction
vryt  = y - t(:,2); 
vryt2 = sum(vryt.^2);
vrat2 = sum((t(:,2) - mean(t(:,2))).^2);
vr    = (1 - vryt2/vrat2)*100;

% error analysis

% output
y = [t(:,1:end-1) y];
A = A';