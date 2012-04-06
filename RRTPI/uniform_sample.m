function [pt] = uniform_sample(dim,llimits,ulimits,param1,param2)
	pt = llimits+(ulimits-llimits).*rand(dim,1);
end
