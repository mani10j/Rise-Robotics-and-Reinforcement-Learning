function [snum] = numifystate(s)
	a = [1 2^2 2^6 2^10];
	snum = a*s'+1;
end

