function [beta] = genbeta(state_arr,opt)
		shape = state_arr(1);
		w = state_arr(2);
		x = state_arr(3);
		
		if opt == 1	  %one hand
			beta = 0.2 + 0.05*w;
			if x >=5 && x <= 9
				 beta = beta*2;
			end
		elseif opt == 2 %two hand
			beta = 0.2 + 0.03*(w-6);
		else			  %push
			beta = 0.2 + 0.01*(w-12);
			if x >=5 && x <= 9
				 beta = beta*2;
			end
		end		
end
