function [agt]=disease(agt)

%eating function for class RABBIT
%agt=rabbit object

%SUMMARY OF RED SQUIRREL DISEASE RULE
%Red squirrel calculates distance to all grey squirrels
%If one equidistant within search radius, red squirrel has a chance to become
%diseased

%GLOBAL VARIABLES
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
   %    MESSAGES.atype - n x 1 array listing the type of each agent in the model
   %    (1=red, 2=grey, 3=dead agent)
   %    MESSAGES.pos - list of every agent position in [x y]
   %    MESSAGE.dead - n x1 array containing ones for agents that have died
   %    in the current iteration

global  IT_STATS N_IT MESSAGES PARAM
   
pos=agt.pos;                        %extract current position                   
spd=agt.speed;                      %squirrel migration speed in units per iteration - this is equal to the disease search radius


typ=MESSAGES.atype;                                             %extract types of all agents
greysq=find(typ==2);                                            %indices of all squirrels
gpos=MESSAGES.pos(greysq,:);                                    %extract positions of all squirrels
csep=sqrt((gpos(:,1)-pos(:,1)).^2+(gpos(:,2)-pos(:,2)).^2);     %calculate distance to all squirrels
[d,ind]=min(csep);                                              %d is distance to closest squirrels, ind is index of that rabbit
nrst=greysq(ind);                                               %index of nearest squirrels(s)

if d<=spd&length(nrst)>0    %if there is at least one  grey squirrel within the search radius        
   
    if 1.0*rand(1,1) < PARAM.DISEASE_PREVALENCE
        IT_STATS.diseased(N_IT+1)=IT_STATS.diseased(N_IT+1)+1;  %update statistics
        agt.diseased = 1;
    end
end