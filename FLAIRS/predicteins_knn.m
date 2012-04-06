function [opt,conf] = predicteins_knn(s,dataset)
	k = 1;
	if size(dataset,1) >= 3
		k = 3;
	end
	y = dataset(:,end);
	
%	opt = knnclassify([s(1)==0, s(1)==1, s(1)==2, s(2)/15, s(3)/14, s(4)],dataset(:,1:end-1),);
	[i,d] = knnsearch([s(1)==0, s(1)==1, s(1)==2, s(2)/15, s(3)/14, s(4)],dataset(:,1:end-1),k);
	
	if (sum(y(i)==1) > sum(y(i)==2))&&(sum(y(i)==1) > sum(y(i)==3))
		maxind = 1;
	elseif (sum(y(i)==2) > sum(y(i)==3))&&(sum(y(i)==2) > sum(y(i)==1))
		maxind = 2;
	else 
		maxind = 3;
	end
	
	%for any general k
	opt = maxind;
	
	conf = 1/(min(d(y(i)==maxind))^2);
end
