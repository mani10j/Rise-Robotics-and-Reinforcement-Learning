function [a] = epsgreedy(Qs,epsilon)

	if rand < epsilon
		a = ceil(rand*size(Qs,2));
	else
		a = findmax(Qs);
	end	
	
end

