function [opt] = generateins(state_arr,Qlearnt)

%		shape = state_arr(1);
%		w = state_arr(2);
%		x = state_arr(3);
		
%		if shape == 0
%			opt = 1;
%		elseif shape == 1
%			opt = 2;
%		else
%			opt = 3;
%			
%		if w >10
%			opt = 3;
%		end
%		
%		if x<10 && x>=5 && w<10
%			opt = 2;
%		end
		
	
		opt = findmax(Qlearnt(numifystate(state_arr),:));
		
end
