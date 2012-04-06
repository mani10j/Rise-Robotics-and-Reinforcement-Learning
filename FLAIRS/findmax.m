function [a] = findmax(Qs)
	[v,i] = max(Qs);
	maxopts = find(Qs==v);
	a=maxopts(ceil(rand*size(maxopts,2)));
end

