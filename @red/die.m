function [agt,klld]=die(agt,cn)

%Modified by J Christian, J Belkhu, L foot 14/5/16

%death function for class SQUIRREL
%agt=squirrel object
%cn - current agent number
%klld=1 if agent dies, =0 otherwise

%squirrel agents have a 50% chance to die each iteration if their food level reaches zero or they are older than max_age


global PARAM IT_STATS N_IT MESSAGES
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%PARAM is data structure containing behavior parameters
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
   %    MESSAGES.atype - n x 1 array listing the type of each agent in the model
   %    (1=rabbit, 2-fox, 3=dead agent)
   %    MESSAGES.pos - list of every agent position in [x y]
   %    MESSAGE.dead - n x1 array containing ones for agents that have died
   %    in the current iteration

klld=0;
thold=PARAM.RED_MINFOOD;      %threshold minimum food value for death to occur
cfood=agt.food;             %get current agent food level
age=agt.age;                %get current agent age
diseased=agt.diseased;
diseasedit=agt.diseasedit;

if cfood<=thold|age>PARAM.RED_MAXAGE      %if food level < threshold and age > max age then agent dies
    if 1.0*rand(1,1) > 0.5
        IT_STATS.died_red(N_IT+1)=IT_STATS.died_red(N_IT+1)+1;  %update statistics
        MESSAGES.dead(cn)=1;                %update message list
        klld=1;
    end
end
if diseased == 1
    
    if diseasedit > PARAM.DISEASE_MORBIDITY
        
        if 1.0*rand(1,1) > 0.5
            IT_STATS.died_red(N_IT+1)=IT_STATS.died_red(N_IT+1)+1;  %update statistics
            MESSAGES.dead(cn)=1;                %update message list
            klld=1;
        end
    end 
    agt.diseasedit = diseasedit + 1;
end
