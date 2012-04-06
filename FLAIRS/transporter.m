%states  [0-2][0-15][0-14][0-1]
%			2	4	  4	 	1
%		 |shape|weight|x|carrying?|
%options [1-3]			
function [time,Q,avgret] = transporter(runs)
	Q=zeros(1983,3);
	time=zeros(1,runs);
	avgret=zeros(1,runs);
	%params
	epsilon=0.07;
	alpha=0.1;
	gamma=0.9;
	%begin episode	
	for i=1:runs	
		%i	
		init_state = [floor(rand*3) floor(rand*16) 0 0];
		state_arr = init_state; 
	%	state_arr=[2 10 0 0];
		state=numifystate(state_arr);
		terminated = 0;
		while terminated~=1
		
			state=numifystate(state_arr);
			%choose option
			opt = epsgreedy(Q(state,:),epsilon);
	

			%run option
			[nextstate_arr,tau,ret,terminated] = runopts(state_arr,opt,gamma);
			time(i) = time(i)+tau;
			avgret(i) = avgret(i)+ret;
			nextstate = numifystate(nextstate_arr);
			nextopt = findmax(Q(nextstate,:));
		
			%SMDP Q learn
			Q(state,opt) = (1-alpha)*Q(state,opt) + alpha*(ret + ( (gamma^tau) * Q(nextstate,nextopt) ) );
		
			state_arr=nextstate_arr;	
		end
		avgret(i) = avgret(i) / time(i);
	end
end
