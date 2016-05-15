function create_params
params = load('params.mat');
params = params.params;
% testpath = load('testpath.mat');
%set up breeding, migration and starvation threshold parameters. These
%are all completely made up!

%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation

global PARAM

    PARAM.RED_SPD=              params(1);         %speed of movement - units per itn (rabbit)
    PARAM.GREY_SPD=             params(2);         %speed of movement - units per itn (fox)
    PARAM.RED_BRDFQ=            params(3);      %breeding frequency - iterations
    PARAM.GREY_BRDFQ=           params(4);
    PARAM.RED_MINFOOD=          params(5);      %minimum food threshold before agent dies 
    PARAM.GREY_MINFOOD=         params(6);
    PARAM.RED_MAXFOOD=          params(7);      %minimum food threshold before agent dies 
    PARAM.GREY_MAXFOOD=         params(8);
    PARAM.RED_FOODBRD=          params(9);     %minimum food threshold for breeding
    PARAM.GREY_FOODBRD=         params(10);
    PARAM.RED_MAXAGE=           params(11);      %maximum age allowed 
    PARAM.GREY_MAXAGE=          params(12);
    PARAM.RED_AGGRO=            params(13);
    PARAM.GREY_AGGRO=           params(14);
    PARAM.RED_COMPETITION=      params(15);
    PARAM.GREY_COMPETITION=     params(16);
    PARAM.DISEASE_PREVALENCE =  params(17);
    PARAM.DISEASE_MORBIDITY =   params(18);
%     PARAM.FILEPATH = testpath{1};
    
    