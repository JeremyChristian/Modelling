function [agt,eaten]=eat(agt,cn)

%Modified by J Christian, J Belkhu, L foot 14/5/16

%eating function for class SQUIRREL
%agt=squirrel object
%cn - current agent number
%eaten = 1 if squirrel finds food, =0 otherwise

%ENV_DATA is a data structure containing information about the model
   %environment
   %    ENV_DATA.shape - shape of environment - FIXED AS SQUARE
   %    ENV_DATA.units - FIXED AS KM
   %    ENV_DATA.bm_size - length of environment edge in km
   %    ENV_DATA.food is  a bm_size x bm_size array containing distribution of food
  
%SUMMARY OF SQUIRREL EAT RULE
%squirrel detects food level in its 1km x 1km square of the environment
%if food> 1, squirrel will consume food
%otherwise squirrel food level decremented by 1.

global  ENV_DATA 

pos=agt.pos;                            %extract current position 
cfood=agt.food;                         %get current agent food level
cpos=round(pos);                        %round up position to nearest grid point
pfood=ENV_DATA.food(cpos(1),cpos(2));   %obtain environment food level at current location

if pfood>=1   
    
    ENV_DATA.food(cpos(1),cpos(2))=ENV_DATA.food(cpos(1),cpos(2))-1;  %reduce environment food by one unit
    if agt.food < 10
        agt.food=cfood+1;                       %increase agent food by one unit
    end
    eaten=1;                                    %squirrel has eaten - set flag to one
else
    agt.food=cfood-1;                           %decrease agent food by one unit
    eaten=0;                                    %flag tells squirrel to migrate
end
    
   
