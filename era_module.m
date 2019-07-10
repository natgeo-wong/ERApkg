function mod = era_module (ini,type)



mod.stp = ini;

len = era_module_disp(ini.act); disp('Please choose the desired mode:');
if nargin ~= 2, type = input('  Mode: '); disp(' ');
else,           fprintf('  Mode: %d\n\n',type);
end
mod.ID = type; 

while ~any(type == 1:len)
    disp('Invalid mode selected.  Please choose again.');
    type = input('  Mode: '); mod.ID = type;
    disp(' ');
end

if     type == 1, mod.type = 'dsfc'; mod.name = 'dry surface';
elseif type == 2, mod.type = 'dpre'; mod.name = 'dry pressure';
elseif type == 3, mod.type = 'msfc'; mod.name = 'moist surface';
elseif type == 4, mod.type = 'mpre'; mod.name = 'moist pressure';
elseif type == 5, mod.type = 'csfc'; mod.name = 'calc surface';
elseif type == 6, mod.type = 'cpre'; mod.name = 'calc pressure';
end

if all([ini.ID ini.act] == 1)
    if any(type == [2 4]), mod.print = 'reanalysis-era5-pressure-levels';
    elseif any(type == [1 3]), mod.print = 'reanalysis-era5-single-levels';
    end
end

end