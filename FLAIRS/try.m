p = [0.5 0.2 0.3];
j=zeros(1,1000);
for i=1:1000;
	[v,ind] = max(rand(1,3)+p);
	j(i)=ind;
end
