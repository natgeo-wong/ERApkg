function par = era_pressure (mod,par)



if any(mod.ID == [2 4 6]), allpre = era_pressure_load;
    disp('All pressure levels will be downloaded.');
    fprintf('Setting pressure level options ... '); par.pre = allpre;
    fprintf('done!\n\n');
else
    disp('Because you have chosen to download a single level module');
    disp('a pressure level input is not required.');
    disp('Setting pressure level to NaN'); par.pre = NaN;
    disp(' ');
end

end