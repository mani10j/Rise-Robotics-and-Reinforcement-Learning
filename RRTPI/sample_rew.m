function [rew,term] = sample_rew(state)
	rew = 0;
	term = false;
	if state(1) > 90 && state(2) > 90
		rew = 100;
		term = true;
	end
	
	

end
