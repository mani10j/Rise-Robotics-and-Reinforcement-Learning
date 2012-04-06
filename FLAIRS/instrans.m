%states  [0-2][0-15][0-14][0-1]
%			2	4	  4	 	1
%		 |shape|weight|x|carrying?|
% 0 - cyli 
% 1 - cube 
% 2 - sphere
%options [1-3]
% 1 - 1hand
% 2 - 2hand
% 3 - push

function [time,Q,avgret] = instrans(runs)
	Q=zeros(1983,3);
	
	Qvar=zeros(1983,3);
	Qmean=zeros(1983,3);
	scount=zeros(1983,3);
	%variance in Q's
	
	time=zeros(1,runs);
	avgret=zeros(1,runs);
	learning=zeros(1,runs);
	%params
	epsilon=0.07;
	alpha=0.1;
	gamma=0.9;
	zeta=0.3;
	
	load QRL;
	
	%populate by at least one ins initially
	insdataset = [];
	dopt = generateins([0 0 0 0],Qlearnt);
	insdataset = [insdataset; [[1 0 0 0 0 0] dopt]]; 

	
	%begin episode	
	for i=1:runs	
		%i	
		init_state = [floor(rand*3) floor(rand*16) 0 0];
		state_arr = init_state; 
	%	state_arr=[2 10 0 0];
		state=numifystate(state_arr);
		terminated = 0;
		no_preds = 0;
		while terminated~=1
		
			state=numifystate(state_arr);
			


			
			%check if instruction is there
			if rand<zeta
				opt = generateins(state_arr,Qlearnt);
				insdataset = [insdataset; [state_arr(1)==0 state_arr(1)==1 state_arr(1)==2 state_arr(2)/15 state_arr(3)/14 state_arr(4) opt]]; 
			else
				
				%predict from inst model
				
				%[insopt, conf] = predicteins_knn(state_arr,insdataset);
				
				no_preds = no_preds + 1;
				
				%choose option from Q				
				rlopt = epsgreedy(Q(state,:),epsilon);
				
				%decide how to compare and chose between the two
				
				opt = rlopt;
				
				%learning(i) = learning(i) + conf;
				
			end
			
			%choose what option to run
		
			
			
			%run that option
			[nextstate_arr,tau,ret,terminated] = runopts(state_arr,opt,gamma);
			time(i) = time(i)+tau;
			avgret(i) = avgret(i)+ret;
			nextstate = numifystate(nextstate_arr);
			nextopt = findmax(Q(nextstate,:));
		
			%SMDP Q learn
			Q(state,opt) = (1-alpha)*Q(state,opt) + alpha*(ret + ( (gamma^tau) * Q(nextstate,nextopt) ) );
			%incrementally update q variances.. 
			scount(state,opt) = scount(state,opt) + 1;
			%this is the var in the updates... not sure if correct
			%Qvar(state,opt) = (Qvar(state,opt)*(scount(state,opt)-1) + (alpha*(ret + ( (gamma^tau) * Q(nextstate,nextopt) ) - Q(state,opt) ))^2)/scount(state,opt);
			
		
			state_arr=nextstate_arr;	
		end
		learning(i) = learning(i) / no_preds;
		avgret(i) = avgret(i) / time(i);
	end
end
