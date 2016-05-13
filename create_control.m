function create_control ()
%Data to enable fast mode and to allow pausing during opperation to zoom
%and pan on the current plotted figure

global CONTROL_DATA

CONTROL_DATA.fmode_display_every = 50;
CONTROL_DATA.fmode_control =[500 1000 2000 4000 8000 ; 50 50 50 50 50];
CONTROL_DATA.pause = false;

end

