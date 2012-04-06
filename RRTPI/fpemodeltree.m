function [model] = fpemodeltree(rrt,no_iters)
%	data = csvread(file);
%	s = data(:,1:2);
%	s_next = data(:,3:4);
%	r = data(:,5);
	s_next = [];
	s = [];
	r = [];
	for i = 1:numel(rrt)
		if(~isempty(rrt(i).parent))
			s_next(i,:) = rrt(i).state;
			s(i,:) = rrt(rrt(i).parent).state;
			r(i) = rrt(i).rew;
		end
	end	
	r = r';	
	y = r;
	
	model = m5pbuild(s,y);
		
	for k = 1:no_iters
		vnext = m5ppredict(model,s_next);
		y = r + 0.9*vnext;
		model = m5pbuild(s,y);
		k;
	end
	

end
