function val=get(c,prop_name)

%Modified by J Christian, J Belkhu, L foot 14/5/16

%standard function to allow extraction of memory parameters from squirrel object

switch prop_name
   
case 'age'
   val=c.age;
case 'food'
   val=c.food;
case 'pos'
    val=c.pos;
case 'speed'
     val=c.speed;
case 'last_breed'
     val=c.last_breed; 
otherwise 
   error('invalid field name')
end

