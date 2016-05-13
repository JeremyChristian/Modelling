function [agt]=disease(agt)

%eating function for class FOX
%agt=fox object
%cn - current agent number
%eaten = 1 if fox successfully finds a rabbit, =0 otherwise

%SUMMARY OF FOX EAT RULE
%Fox calculates distance to all rabbits
%Fox identifies nearest rabbits(s)
%If more than one equidistant within search radius, one is randomly picked
%Probability of fox killing rabbit =1 - distance of rabbit/speed of fox
%If probability > rand, fox moves to rabbit location and rabbit is
%killed
%If fox does not kill rabbit, it's food is decremented by one unit

%GLOBAL VARIABLES
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
   %    MESSAGES.atype - n x 1 array listing the type of each agent in the model
   %    (1=rabbit, 2-fox, 3=dead agent)
   %    MESSAGES.pos - list of every agent position in [x y]
   %    MESSAGE.dead - n x1 array containing ones for agents that have died
   %    in the current iteration
   
     
%Modified by D Walker 3/4/08

global  IT_STATS N_IT MESSAGES PARAM
   
pos=agt.pos;                        %extract current position                   
spd=agt.speed;                      %fox migration speed in units per iteration - this is equal to the food search radius


typ=MESSAGES.atype;                                         %extract types of all agents
greysq=find(typ==2);                                            %indices of all rabbits
gpos=MESSAGES.pos(greysq,:);                                     %extract positions of all rabbits
csep=sqrt((gpos(:,1)-pos(:,1)).^2+(gpos(:,2)-pos(:,2)).^2);  %calculate distance to all rabbits
[d,ind]=min(csep);                                            %d is distance to closest rabbit, ind is index of that rabbit
nrst=greysq(ind);                                                %index of nearest rabbit(s)

if d<=spd&length(nrst)>0    %if there is at least one  rabbit within the search radius        
   
    if 1.0*rand(1,1) < PARAM.DISEASE_PREVALENCE
        IT_STATS.diseased(N_IT+1)=IT_STATS.diseased(N_IT+1)+1;  %update statistics
        agt.diseased = 1;
    end
end