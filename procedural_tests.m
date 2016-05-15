tests = load('tests.mat');
filepaths = load('filepath.mat');

params = [];
test=1;
conditions=1;
run_total = 0;

for x=1:length(tests.l(1,:))                            % For every test and its subtests (totalling 40)
    for y=1:length(tests.l(:,x))                        % Take the parameters for that test
        params(y) = (tests.l(y,x));                     % And set the params variable
    end
    
    save('params.mat','params','-double');              % Save the params variable
    
    path = filepaths.filepath{test};                            % Get the file name using the test variable
    path = ['tests/' path '/subtest_' int2str(conditions)];     % Add the parent and sub directory to the path
    mkdir(path);                                                % Make the directory structure
    
    for i=1:10          % Run each test 10 times to reduce stocastic implications
        
        mkdir([path '/run_' num2str(i)]);       
        testpath = {[path '/run_' num2str(i)]};
        save('testpath.mat','testpath');
        ecolab(18,params(19),params(20),1000,true,true);
        
        run_total =+ 1;
        conditions =+ 1;
        
        if mod(test,5) == 0;
            test=+1;
            conditions = 1;
        end
        
    end
end
