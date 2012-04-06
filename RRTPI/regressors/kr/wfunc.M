function w=wfunc(varargin)
% W=WFUNC(LEARN,K,TEST)
%
% LEARN = [LX(:,1:D), LY(:,1)]
% TEST  = [TX(:,1:D), TY(:,1)]
% K     from [0,Inf)
%
% Uses exponential weight kernel
%
%  W = EXP(-K * D(i,j) + a * t)
% 
% where the normalized distance is used
%
%  D(i,j) = sum((LX(i,d)-TX(i,d)/N(d))^2)
%
% here the normalization function N is 
% given by the range of LX and TX
%
%  N = max([LX;TX])-min([LX;TX]);
%
% Used by YKR

% $Revision: 1.1 $ $Date: 2004-09-06 09:00:11+02 $ $Author: tgebbie $

switch nargin
case 3
    x = varargin{1};
    k = varargin{2};
    t = varargin{3};
    a = [];
case 4
    x = varargin{1};
    k = varargin{2};
    t = varargin{3};
    a = varargin{4};
    % if the first column is the time index
    if ~isempty(a)
     tt = t(:,1); t = t(:,2:end);
     tx = x(:,1); t = t(:,2:end);
    end
    
otherwise
    error('Incorrect Input Arguments');
end
  
    % size of x
    [m,n]=size(x);
    % size of t
    [mt,nt]=size(t);
    
    % the number of variables
    d = 1:n-1;
    % setting the dimenions
    range=[x(:,d); t(:,d)];
    % ensure the 1 dimensional kr behave nicely
    if n-1==1
     nd(d)=1;   
    else
     nd=max(range)-min(range);
    end
    % the loop
    for i=1:m,for j=1:mt, d2(i,j)=sum(((x(i,d)-t(j,d))./nd(d)).^2); end; end;
    % kernel
    w = exp(-k * d2 );
    
    % if there is a half-life use it
    if ~isempty(a)
     % generate the half-live factor
     h = a * tx';
     % time-weight the kernel
     w = w .* repmat(exp(h),1,mt);
    end
   