function [y, vr, err] = ykr0(x,k,t)
% [Y, VR, ERR] = YKR0(LEARN,k,TEST)
%
% 0-order kernel regression
%
% Input:
% ------
%
%  LEARN =      1    12.00
%               3    18.00
%               5    20.00
%               7    17.00
%  TEST  =      2    14.00
%               4    18.50
%               6    19.00
%  k     =      0.1
%
% Output:
% -------
%  Y     =      2    15.96
%               4    17.61
%               6    18.18
%  VR (variance reduction) =    65.05 %

% $Revision: 1.1 $ $Date: 2004-09-06 09:00:11+02 $ $Author: tgebbie $

% the distance function
d = repmat(x(:,1),1,length(t(:,1))) - repmat(t(:,1)',length(x(:,1)),1);
% the squared distance function
d2 = d.^2;
% create the kernel functions
w = exp(-k * d2 );
% generate the test kernel regression
y = x(:,2)' * w ./ sum(w);

% variance reduction
vry  = y' - t(:,2); 
vry  = sum(vry.^2);
vra  = sum((t(:,2) - mean(t(:,2))).^2);
vr   =(1 - vry/vra)*100;

% error estimate
err = sqrt(sum((repmat(x(:,2),1,length(y))-repmat(y,length(x(:,2)),1)).^2 .* w)./sum(w))';

% out put
y = [t(:,1) y'];