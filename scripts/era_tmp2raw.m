%                            era_extractreg.m
%    Script that creates python script to download ECMWF reanalysis data
%                          Nathanael Wong Zhixin
%
% This script creates a python script that, when run in terminal, can be
% used to download ECMWF reanalysis data, for both ERA-Interim and ERA5.
% The user must select the variable to be downloaded (one per script, for
% maximum performance), and then select the pressure level (when
% applicable), timestep (when applicable), and also the time-range for the
% data that is to be downloaded.
%
% Based on all the inputs given, a python script and enclosing folder will
% be created.

[ ini,root,logf ] = era_startup(2,2);
[ mod,par,trange,reg ] = era_initialize(ini,1,7,1);

fprintf('Proceeding to move data from tmp to raw folder.\n\n');

pvec = par.pre; mod.pre = par.pre;
for ii = pvec, par.pre = ii;
    
    fol = era_folder(par,reg,root);
    cd(fol.tmp); fnc = dir('*.nc'); lnc = length(fnc); cd(root.era);
    for jj = 1 : lnc, movefile([fol.tmp '/' fnc(jj).name],fol.raw); end
    
end
par.pre = pvec;
fprintf('Downloaded data moved to raw folder.\n\n');

era_shutdown(logf,[fol.var '/raw']);
