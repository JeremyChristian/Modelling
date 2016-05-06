function initialise_results(nred,ngrey,nsteps)

 global  IT_STATS ENV_DATA 
 
%set up data structure to record statistics for each model iteration
%IT_STATS  -  is data structure containing statistics on model at each
%iteration (number of agents etc)
%ENV_DATA - data structure representing the environment 
 
 IT_STATS=struct('div_red',[zeros(1,nsteps+1);],...            %no. births per iteration
                'div_grey',[zeros(1,nsteps+1)],...
                'died_red',[zeros(1,nsteps+1)],...			%no. agents dying per iteration
                'died_grey',[zeros(1,nsteps+1)],...		
                'eaten',[zeros(1,nsteps+1)],...              %no. rabbits eaten per iteration
                'diseased',[zeros(1,nsteps+1)],... 
                'mig',[zeros(1,nsteps+1)],...                %no. agents migrating per iteration
                'tot',[zeros(1,nsteps+1)],...				%total no. agents in model per iteration
                'tot_red',[zeros(1,nsteps+1)],...             % total no. rabbits
                'tot_grey',[zeros(1,nsteps+1)],...             % total no. foxes
                'tfood',[zeros(1,nsteps+1)]);               %remaining vegetation level
            
 
 tgrey=sum(sum(ENV_DATA.food));            %remaining food is summed over all squares in the environment
 IT_STATS.tot(1)=nred+ngrey;
 IT_STATS.tot_red(1)=nred;
 IT_STATS.tot_grey(1)=ngrey;
 IT_STATS.tfood(1)=tgrey;
