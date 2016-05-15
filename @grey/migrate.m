function [agt]=migrate(agt,cn,eaten)

%migration functions for squirrel
%agt=squirrel object
%cn - current agent number

%SUMMARY OF SQUIRREL MIGRATE RULE

%If they have not eaten Squirrels will always try to migrate towards the largest food source
%The squirrel will extract the distibution of food in its LOCAL environment (at
%distances < its daily migration limit)
%It will identify the location with the most food and migrate into it.
%It's new position will be randomly placed within this square
%If no food is detected within its search radius it will move randomly (up
%to 8 atempts without leaving the model edge)
%Regardless of whether they have eaten they will move away from squirrels of the opposite species
%If surrounded by members of their own species they will migrate in a random direction to disperse.

global ENV_DATA IT_STATS N_IT MESSAGES PARAM
%N_IT is current iteration number
%IT_STATS is data structure containing statistics on model at each
%iteration (no. agents etc)
%interpolated to each grid point
%ENV_DATA is a data structure containing information about the model
   %environment
   %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
   %    ENV_DATA.units - FIXED AS KM
   %    ENV_DATA.bm_size - length of environment edge in km
   %    ENV_DATA.food is  a bm_size x bm_size array containing distribution
   %    of food

mig=0;                               %indicates whether squirrel has successfully migrated
pos=agt.pos;                         %extract current position 
cpos=round(pos);                     %round up position to nearest grid point   
spd=agt.speed;                       %rabbit migration speed in units per iteration - this is equal to the food search radius

typ=MESSAGES.atype;                                         %extract types of all agents
rb=find(typ==1);                                            %indices of all red squirrels
rpos=MESSAGES.pos(rb,:);                                     %extract positions of all red squirrels
dist=sqrt((rpos(:,1)-pos(:,1)).^2+(rpos(:,2)-pos(:,2)).^2);  %calculate distance to all red squirrels
danger_squirrels = [];
i=1;

for i=1:length(rb)
    if dist(i)<=spd
        danger_squirrels = [danger_squirrels,i];
    end
end


gb=find(typ==2);                                            %indices of all grey squirrels
gpos=MESSAGES.pos(gb,:);                                     %extract positions of all  grey squirrels
gdist=sqrt((gpos(:,1)-pos(:,1)).^2+(gpos(:,2)-pos(:,2)).^2);  %calculate distance to all  grey squirrels
grey_squirrels = [];


for i=1:length(gb)
    if gdist(i)<=spd
        grey_squirrels = [grey_squirrels,i];
    end
end


nx = 0;
ny = 0;
c = 0;
mig=0;                          %flag will be reset to one if squirrel migrates
[loc_food,xmin,ymin]=extract_local_food(cpos,spd);

[food_x,food_y] = find(loc_food == max(loc_food(:)));

 if length(danger_squirrels) > PARAM.GREY_AGGRO       
     for i=1:length(danger_squirrels)
         nx =+ rpos(danger_squirrels(i),1);
         ny =+ rpos(danger_squirrels(i),2);
     end
     nx = nx / c;
     ny = ny / c;
     
     
     cnt=0;
     angle = atan(ny-pos(2)/nx-pos(1));
     while mig==0&cnt<=8    
         npos(1)=pos(1)+spd*cos(angle);        %new x co-ordinate
         npos(2)=pos(2)+spd*sin(angle);        %new y co-ordinate
         if npos(1)<ENV_DATA.bm_size&npos(2)<ENV_DATA.bm_size&npos(1)>=1&npos(2)>=1   %check that squirrel has not left edge of model - correct if so.
            mig=1;
         end
         cnt=cnt+1;
         angle=angle+(pi/4);         %if migration not successful, then increment direction by 45 degrees and try again
     end
     
 elseif eaten == 0            
        
    s=round(rand*(length(food_x)-1))+1;
    food_pos = [food_x(s),food_y(s)];

    nx=food_pos(1)+rand-0.5+xmin;
    ny=food_pos(2)+rand-0.5+ymin;
    npos=[nx ny];
    %if agent has left edge of model, then adjust slightly
    shft=find(npos>=ENV_DATA.bm_size);
    npos(shft)=ENV_DATA.bm_size-rand;
    shft=find(npos<=1);
    npos(shft)=1+rand;
    mig=1;
end
    
if mig==0 && eaten == 0                     %squirrel has been unable to find food, so chooses a random direction to move in      
    cnt=1;
    dir=rand*2*pi;              
    while mig==0&cnt<=8                     
        npos(1)=pos(1)+spd*cos(dir);        %new x co-ordinate
        npos(2)=pos(2)+spd*sin(dir);        %new y co-ordinate
        if npos(1)<ENV_DATA.bm_size&npos(2)<ENV_DATA.bm_size&npos(1)>=1&npos(2)>=1   %check that squirrel has not left edge of model - correct if so.
           mig=1;
        end
        cnt=cnt+1;
        dir=dir+(pi/4);         %if migration not successful, then increment direction by 45 degrees and try again
    end
end

if mig==1
    agt.pos=npos;                                   %update agent memory
    IT_STATS.mig(N_IT+1)=IT_STATS.mig(N_IT+1)+1;    %update model statistics
end