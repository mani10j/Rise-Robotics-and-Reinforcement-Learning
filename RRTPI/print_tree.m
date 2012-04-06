function print_tree(rrt,k)
	points = [rrt.state];
	plot(points(1,:),points(2,:),'r.');
	if(k>0)
		temps = sprintf('i%d_rrt',k);
		print('-dpng',temps); 
	end
end
