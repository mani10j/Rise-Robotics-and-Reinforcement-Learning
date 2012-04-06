p = [0.4 0.3 0.2 0.1];
j=zeros(1,100000);
for i=1:100000;
	[v,ind] = max(rand(size(p))+p);
	j(i)=ind;
end
