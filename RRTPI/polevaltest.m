function [hyp] = polevaltest(rrt,no_iters)
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
	
	covfunc = @covSEiso;
	meanfunc = {@meanSum, {@meanLinear, @meanConst}};
	likfunc = @likGauss;
	hyp.cov = [0; 0]; hyp.mean = [0; 0; 0]; hyp.lik = log(0.1);
	hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, s, y);

		
	for k = 1:no_iters
		[ymean,ycov] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, s, y, s_next);
		y = r + 0.9*ymean;
		hyp.cov = [0; 0]; hyp.mean = [0; 0; 0]; hyp.lik = log(0.1);
		hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, s, y);
		k
	end
	

%	V = val_viz(params);
%	surf(V','EdgeColor','none');
%	figure,imagesc(V');
end
