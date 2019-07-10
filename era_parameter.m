function par = era_parameter (mod,parID)



parlist = era_parameter_load(mod); npar = length(parlist);
          era_parameter_disp(mod.name,parlist);

disp('Please choose the desired variable:');
if nargin ~= 2, parID = input('  Variable: '); disp(' ');
else,           fprintf('  Variable: %d\n\n',parID);
end

while ~any(parID == 1:npar)
    disp(['Invalid choice for ' mod.name ' mode.  Please try again']);
    parID = input('  Variable: ');
    disp(' ');
end

parlist = parlist(parID,:);
par.ID   = parlist{:,2}; par.IDnc = parlist{:,3}; par.era5 = parlist{:,4};
par.erai = parlist{:,5}; par.name = parlist{:,6}; par.unit = parlist{:,7};

fprintf('ERApkg will %s the following variables:\n',mod.stp.actstr);
fprintf('  - %s\n\n',par.name);

end