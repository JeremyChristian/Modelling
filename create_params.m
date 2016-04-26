function create_params

%set up breeding, migration and starvation threshold parameters. These
%are all completely made up!

%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation

global PARAM

    PARAM.RED_SPD=2;         %speed of movement - units per itn (rabbit)
    PARAM.GREY_SPD=2;         %speed of movement - units per itn (fox)
    PARAM.RED_BRDFQ=10;      %breeding frequency - iterations
    PARAM.GREY_BRDFQ=10;
    PARAM.RED_MINFOOD=0;      %minimum food threshold before agent dies 
    PARAM.GREY_MINFOOD=0;
    PARAM.RED_FOODBRD=10;     %minimum food threshold for breeding
    PARAM.GREY_FOODBRD=10;
    PARAM.RED_MAXAGE=50;      %maximum age allowed 
    PARAM.GREY_MAXAGE=50;
    
    