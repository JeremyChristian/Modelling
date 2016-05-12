function [nagent,nn]=agnt_solve(agent)

%sequence of functions called to apply agent rules to current agent population.
%%%%%%%%%%%%
%[nagent,nn]=agnt_solve(agent)
%%%%%%%%%%%
%agent - list of existing agent structures
%nagent - list of updated agent structures
%nn - total number of live agents at end of update

%Created by Dawn Walker 3/4/08 

n=length(agent);    %current no. of agents
n_new=0;    %no. new agents
prev_n=n;   %remember current agent number at the start of this iteration

global ENV_DATA 

% mapObj = containers.Map();
% 
% for x = 1:ENV_DATA.size
%     for y = 1:ENV_DATA.size
%         if 
%         mapObj({x,y}) = ENV_DATA.food(x,y);

%execute existing agent update loop
for cn=1:n
	curr=agent{cn};
    if isa(curr,'red')|isa(curr,'grey')
        if isa(curr,'red')
            curr=disease(curr);
        end
        [curr,eaten]=eat(curr,cn);              %eating rules (rabbits eat food, foxes eat rabbits)
        
        curr=migrate(curr,cn,eaten);              %if no food was eaten, then migrate in search of some
        
        [curr,klld]=die(curr,cn);                %death rule (from starvation or old age)
        if klld==0
            new=[];
            [curr,new]=breed(curr,cn);			%breeding rule
            if ~isempty(new)					%if current agent has bred during this iteration
                 n_new=n_new+1;                 %increase new agent number
                 agent{n+n_new}=new;			%add new to end of agent list
             end
        end
       agent{cn}=curr;                          %up date cell array with modified agent data structure
    end
end
%%%%%
% for x=1:ENV_DATA.bm_size
%     for y = 1:ENV_DATA.bm_size
%         i = ENV_DATA.food(x,y);
%         if i < 5
%             ENV_DATA.food(x,y) =+ 1;
%         end
%     end
% end
%%%%%%%
size = ENV_DATA.bm_size; % ease of use lawl
for x = 1:size
    for y = 1:size
       if x * y > 0.9 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 10
               
                ENV_DATA.food(x,y) =+ 9;
           end
       elseif x * y > 0.8 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 9
                ENV_DATA.food(x,y) =+ 8;
           end
       elseif x * y > 0.7 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 9
                ENV_DATA.food(x,y) =+ 8;
           end
       elseif x * y > 0.6 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 8
                ENV_DATA.food(x,y) =+ 7;
           end
       elseif x * y > 0.5 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 4
                ENV_DATA.food(x,y) =+ 4;
           end
       elseif x * y > 0.4 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 3
                ENV_DATA.food(x,y) =+ 3;
           end
       elseif x * y > 0.3 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 3
               
                ENV_DATA.food(x,y) =+ 3;
           end
       elseif x * y > 0.2 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 2
               
                ENV_DATA.food(x,y) =+ 1;
           end
       elseif x * y > 0.1 * size ^ 2
           foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 2
               
                ENV_DATA.food(x,y) =+ 1;
           end
       else
          foodlvl = ENV_DATA.food(x,y);
           if foodlvl < 10
               
%                 ENV_DATA.food(x,y) =+ 1;
           end
        end
    end
end

    
       
       

temp_n=n+n_new; %new agent number (before accounting for agent deaths)
[nagent,nn]=update_messages(agent,prev_n,temp_n);   %function which update message list and 'kills off' dead agents.

