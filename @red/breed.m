function [agt, new]=breed(agt,cn)

%breeding function for class SQUIRREL
%agt=squirrel object
%cn - current agent number
%new - contains new  agent object if created, otherwise empty

global PARAM IT_STATS N_IT 
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%PARAM is data structure containing behavior parameters
   
flim=PARAM.RED_FOODBRD;       %minimum food level required for breeding
tlim=PARAM.RED_BRDFQ;         %minimum interval required for breeding
cfood=agt.food;              %get current agent food level
age=agt.age;                %get current agent age
last_breed=agt.last_breed;  %length of time since agent last reproduced
pos=agt.pos;         %current position

if cfood>=flim&last_breed>=tlim  %if food > threshold and age > interval, then create offspring
    if 1.0*rand(1,1) > 0.5  %squirrels have a 50% chance to breed
       new=red(0,cfood/2,pos,PARAM.RED_SPD,0);   %new squirrel agent
       agt.food=cfood/2;                          %divide food level between 2 agents
       agt.last_breed=0;
       agt.age=age+1;
       IT_STATS.div_red(N_IT+1)=IT_STATS.div_red(N_IT+1)+1;             %update statistics
    else                            
        agt.age=age+1;                          %not able to breed, so increment age by 1
        agt.last_breed=last_breed+1;
        new=[];
    end
else                            
    agt.age=age+1;                          %not able to breed, so increment age by 1
    agt.last_breed=last_breed+1;
    new=[];
end