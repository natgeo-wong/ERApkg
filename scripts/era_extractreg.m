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

%#ok<*PFBNS>

clear all; [ ini,root,logf ] = era_startup(2,2);
[ mod,par,trange,reg ] = era_initialize(ini,1,3,4);

fprintf('Proceeding to extract data for the %s region.\n\n',reg.ID);

pvec = par.pre; mod.pre = par.pre;

if isempty(gcp('nocreate')), pobj = parpool(31); end
for ii = 1 : length(pvec), par.pre = pvec(ii); dreg = [];
    
    fol = era_folder(par,reg,root); rmdir([fol.var '/tmp'],'s');
    dreg.raw = strrep(fol.raw,reg.ID,reg.dwn);
    dreg.reg = strrep(fol.reg,reg.ID,reg.dwn);
    cd(dreg.reg); dwn = load('info_reg.mat'); I = era_region_nc(reg,dwn);
    cd(dreg.raw); fnc = dir('*.nc'); lnc = length(fnc); cd(root.era);
    fprintf('\n');
    
    parfor jj = 1 : lnc, oname = fnc(jj).name; t = [];
        
        nname = strrep(oname,reg.dwn,reg.ID);
        jjname = [dreg.raw '/' oname];
        
        tic; data = era_ncread(jjname,par,I.beg,I.fin); t(1) = toc;
        tic; era_extractreg_ncsave(nname,data,par,reg); t(2) = toc;
        fprintf(['Extracted %s region data from %s region for %d\n' ...
                 '    File Details:\n' ...
                 '        Old ncFile Name: %s\n' ...
                 '        New ncFile Name: %s\n' ...
                 '    Total Elapsed Time: %.2f sec\n' ...
                 '        Extraction: %.2f sec\n' ...
                 '        Save netCDF: %.2f sec\n' ...
                 '    Variable: %s\n\n' ], ...
                 reg.ID,reg.dwn,jj+1978,oname,nname,sum(t),t,par.name);
        
        movefile(nname,fol.raw);
        
    end
    
end
delete(pobj);

par.pre = pvec;
fprintf('\nExtraction of data for the %s region completed!\n\n',reg.ID);

save('info_par.mat','mod','par'); save('info_reg.mat','reg');
movefile('info_par.mat',fol.var); movefile('info_reg.mat',fol.reg);

era_shutdown(logf,[fol.var '/raw']); clear all;