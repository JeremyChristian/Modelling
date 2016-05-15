classdef grey       %declares grey object
    properties      %define grey properties (parameters) 
        age; 
        food;
        pos;
        speed;
        last_breed;
    end
    methods                         %note that this class definition mfile contains only the constructor method!
                                    %all additional member functions associated with this class are included as separate mfiles in the @grey folder. 
        function r=grey(varargin) %constructor method for grey - assigns values to grey properties
                %r=grey(age,food,pos....)
                %age of agent (usually 0)
                %food - amount of food that grey has eaten
                %pos - vector containg x,y, co-ords 

                %Modified by J Christian, J Belkhu, L foot 14/5/16


                switch nargin           %Use switch statement with nargin,varargin contructs to overload constructor methods
                    case 0				%create default object
                       r.age=[];			
                       r.food=[];
                       r.pos=[];
                       r.speed=[];
                       r.last_breed=[];
                    case 1              %input is already a grey, so just return!
                       if (isa(varargin{1},'grey'))		
                            r=varargin{1};
                       else
                            error('Input argument is not a grey')
                            
                       end
                    case 5               %create a new grey (currently the only constructor method used)
                       r.age=varargin{1};               %age of grey object in number of iterations
                       r.food=varargin{2};              %current food content (arbitrary units)
                       r.pos=varargin{3};               %current position in Cartesian co-ords [x y]
                       r.speed=varargin{4};             %number of kilometres grey can migrate in 1 day
                       r.last_breed=varargin{5};        %number of iterations since grey last reproduced.
                    otherwise
                       error('Invalid no. of input arguments')
                end
        end
    end
end
