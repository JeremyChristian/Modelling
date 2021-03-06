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
   %    (1=red, 2=grey, 3=dead agent)
   %    MESSAGES.pos - list of every agent position in [x y]
   %    MESSAGE.dead - n x1 array containing ones for agents that have died
   %    in the current iteration

klld=0;
thold=PARAM.GREY_MINFOOD;       %threshold minimum food value for death to occur
cfood=agt.food;                 %get current agent food level
age=agt.age;                    %get current agent age

if cfood<=thold|age>PARAM.GREY_MAXAGE
    if rand(1,1) > 0.5  %if food level < threshold and age > max age then has a 50% chance to die
        IT_STATS.died_grey(N_IT+1)=IT_STATS.died_grey(N_IT+1)+1;    %update statistics
        MESSAGES.dead(cn)=1;                                        %update message list
        klld=1;
    end
end
