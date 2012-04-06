function [V] = val_viz(tree)
	for i=1:100
		for j=1:100
			V(i,j) = eval(tree, [i j]);
		end
		i;
	end
	
end
