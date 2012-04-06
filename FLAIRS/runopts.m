function [nextstate_arr,tau,ret,terminated] = runopts(state_arr,opt,gamma)
	s = state_arr;
	terminated =0;
	shape = state_arr(1);
	w = state_arr(2);
	x = state_arr(3);
	pbeta = zeros(1,6);

	for i=1:5
		pbeta(i) = min(genbeta(s,opt),1);
		s(3) = s(3) + 1;
	end
	pbetaf=pbeta;
	pbetaf(1) = pbeta(1);	
	pbetaf(2) = (1-pbeta(1))*pbeta(2);
	pbetaf(3) = (1-pbeta(1))*(1-pbeta(2))*pbeta(3);
	pbetaf(4) = (1-pbeta(1))*(1-pbeta(2))*(1-pbeta(3))*pbeta(4);
	pbetaf(5) = (1-pbeta(1))*(1-pbeta(2))*(1-pbeta(3))*(1-pbeta(4))*pbeta(5);
	pbetaf(6) = 1 - sum(pbetaf(1:5));
	[v,numsteps] = max(rand(size(pbetaf))+pbetaf);

%check for termination of episode
	if numsteps + state_arr(3) -1 >= 14
		terminated = 1;
		numsteps = 14 - state_arr(3) + 1;
	end

%go to last state of option
	nextstate_arr = [state_arr(1) state_arr(2) state_arr(3)+(numsteps-1) opt~=3&&numsteps==6];
	
	if opt == 1	  	%one hand
		time = 1;
		if shape==0 %cylinder
			time = time - 0.1;
		end
	elseif opt == 2 %two hand
		time = 1.4;
		if shape==1 %cube
			time = time - 0.1;
		end
	else			%push
		time = 2;
		if shape==0
			time = time - 0.1;
		elseif shape==1
			time = time + 0.1;
		else
			time = time - 0.2;
		end
	end
	tau = numsteps*time; 
	if(state_arr(4)==0)
		if opt==1
			tau=tau+w/12;
		elseif opt==2
			tau=tau+w/12;
		end
	end
	
	ret = -1*((1-gamma^tau)/(1-gamma));
	
	if terminated==1
		ret = ret + gamma^tau*20;
	end
end
