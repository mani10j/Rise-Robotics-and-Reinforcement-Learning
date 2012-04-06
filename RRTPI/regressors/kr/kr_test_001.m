% TEST DATA
learn = [1, 12; 3, 18.0; 5, 20.0; 7, 17.0];
test  = [2, 14.0; 4, 18.5; 6, 19.0];
clear w;
% KERNEL REGRESSION 0 : script example of 0-order algorithm
% the kernel coefficient
k = [0.1,1];
% the distance function
d = repmat(learn(:,1),1,length(test(:,1))) - repmat(test(:,1)',length(learn(:,1)),1);
% the squared distance function
d2 = d.^2;
% create the kernel functions
for i=1:length(k), w(:,:,i) = exp(-k(i) * d2 ); end;
% generate the test kernel regression
for i=1:length(k), out(i,:) = learn(:,2)' * w(:,:,i) ./ sum(w(:,:,i)); end; 
% generate the variance ratio (for variance reduction)
vry  = out' - repmat(test(:,2),1,length(k)); 
vry  = sum(vry.^2);
vra  = sum((test(:,2) - mean(test(:,2))).^2);
vr   =(1 - vry/vra)*100;

% KERNEL REGRESSION 1 : example of 0-order algorithm
[y, vr] = ykr0(learn,0.1,test);

% KERNEL REGRESSION 2 : script example of 1-order and 2-order algorithms
% generate the variance ratio (for variance reduction)
[ y, vr, A] = ykr(learn,1,test,0);
[ y, vr, A] = ykr(learn,1,test,1);
[ y, vr, A] = ykr(learn,1,test,2);

% EQUAL WEIGHTING EXAMPLE
learn2 = [1, -6, 5; 3, 8, -11; 5, 0, 9; 7, 2, -3; 9, -5, 53; 11, 7,-57; 13, 3, -19; 15, -1, 31];
test2  = [2, 0, 5; 6, 4, -11; 10, -2, 31];

% TABLE 3.6 Wolberg
[ y, vr, A] = ykr(learn2,0,test2,0);
[ y, vr, A] = ykr(learn2,0,test2,1);
[ y, vr, A] = ykr(learn2,0,test2,2);

% compare surface interpolation
% [ y, vr, A] = ykr(learn2,0,learn2,2);
% surf(y); shading interp; surface(learn2); 
% A=c_fin_array({'R157','IV01','R150'},'PeregrineQuant','m'); D=A(:,:,'ClosePrice'); X=D.values(end-25:end,:);
% learn3 = X(1:end-6,:);
% test3 = X(end-7:end,:);
% [Y, VR] = YKR(learn3,10,test3,0);


