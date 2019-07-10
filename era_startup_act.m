function act = era_startup_act(ID)



if nargin == 0
    disp('Do you wish to download or analyse data?')
    disp('1) Download | 2) Analyse');
    
    disp('Please choose the desired action:');
    act.ID = input('  Action: ');
    disp(' ');
    
    while ~any(act == 1:2)
        disp('Invalid reanalysis dataset option.  Please choose again.');
        act.ID = input('  Action: ');
        disp(' ');
    end
else, act.ID = ID;
end

if act.ID == 1, act.name = 'download';
else,           act.name = 'analyse';
end

end