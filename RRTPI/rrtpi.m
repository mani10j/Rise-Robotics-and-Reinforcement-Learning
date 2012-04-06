function [rrt,param] = rrtpi(num_iters)
	llimits = [0;0];
	ulimits = [100;100];
	dim = 2;
	startpt = [10;10];
	rrt = build_rrt(startpt,dim,llimits,ulimits,5000,@uniform_sample,0,0);
	for z = 1:num_iters
		temps = sprintf('Iter no %d',z);
		print_tree(rrt,z);
		disp(temps);
		disp('Evaluating Policy');
		%[param] = fpemodeltree(rrt,50);
		[param] = polevaltest(rrt,10);
		%[param,V] = fpe(rrt,10);
		print_valfunc(param,z);
		[B,index] =  resample_set(param,2,llimits,ulimits,20000);
		disp('Building RRT');
		rrt = build_rrt(startpt,dim,llimits,ulimits,5000,@bias_sample,B,index);
	end
	print_tree(rrt,num_iters+1);
end
