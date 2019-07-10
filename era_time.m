function trange = era_time (ini)



[ yr,~,~,~,~,~ ] = datevec(now);

if ini.act == 1
    
    disp('ERApkg downloads datasets a year at a time.  Please choose');
    disp('the following date-range options:');
    disp('  0) Entire valid dataset range (1979-previous year)');
    disp('  1) Single year defined by user');
    disp('  2) Start defined by user, ends at the previous year');
    disp('  3) Both start and stop years are defined by user');
    disp('  4) Starts from 1979, end defined by user input');
    disp(' ');
    
    disp('Please choose date-range type.');
    ii = input('  Date-Range Type: ');
    
    while ~any(ii == 0:4)
        disp(' ');
        disp('Invalid date-range type selected.  Please choose again.');
        ii = input('  Date-Range Type: ');
    end
    
    if     ii == 0, b = 1979;                    f = yr-1;
    elseif ii == 1, b = input('  Year: ');       f = b;
    elseif ii == 2, b = input('  Year Begin: '); f = yr-1;
    elseif ii == 3, b = input('  Year Begin: '); f = input('  Year End: ');
    elseif ii == 4, b = 1979;                    f = input('  Year End: ');
    end
    
    if ini.ID == 2,  if f > 2019, f = 2019; end; end
    
elseif ini.act == 2, b = 1979; f = yr-1;
end

disp(' ');
fprintf('ERApkg will %s data from %d to %d.\n\n',ini.actstr,b,f);

trange = [ b f ];

end