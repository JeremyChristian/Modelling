function [agent]=create_agents(nred,ngrey)

 %creates the objects representing each agent
 
%agent - cell array containing list of objects representing agents
%nr - number of rabbits
%nf - number of foxes

%global parameters
%ENV_DATA - data structure representing the environment (initialised in
%create_environment.m)
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation
 
 global ENV_DATA MESSAGES PARAM 
  
bm_size=ENV_DATA.bm_size;
red_loc=(bm_size-1)*rand(nred,2)+1;      %generate random initial positions for rabbits
grey_loc=(bm_size-1)*rand(ngrey,2)+1;      %generate random initial positions for foxes

MESSAGES.pos=[red_loc;grey_loc];

%generate all rabbit agents and record their positions in ENV_MAT_R


%generate all fox agents and record their positions in ENV_MAT_F
for grey_squirrel=1:ngrey
    pos=grey_loc(grey_squirrel,:);
    %create fox agents with random ages between 0 and 10 days and random
    %food levels 20-40
    age=ceil(rand*10);
    food=ceil(rand*20)+20;
    lbreed=round(rand*PARAM.GREY_BRDFQ);
    agent{grey_squirrel}=grey(age,food,pos,PARAM.GREY_SPD,lbreed);
end
for red_squirrel=ngrey+1:ngrey+nred
    pos=red_loc(red_squirrel-ngrey,:);
    %create rabbit agents with random ages between 0 and 10 days and random
    %food levels 20-40
    age=ceil(rand*10);
    food=ceil(rand*20)+20;
    lbreed=round(rand*PARAM.RED_BRDFQ);
    agent{red_squirrel}=red(age,food,pos,PARAM.RED_SPD,lbreed);
end