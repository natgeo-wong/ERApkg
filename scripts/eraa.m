%                                 eraa.m
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
[ mod,par,trange,reg ] = era_initialize(ini,5,4,1);
PI_ID = 4;

fprintf('Proceeding to analyse data for the %s region.\n\n',reg.ID);

pvec = par.pre; mod.pre = par.pre;

if isempty(gcp('nocreate')), pobj = parpool(31); end
for ii = 1 : length(pvec), par.pre = pvec(ii); dreg = [];
    
    fol = era_folder(par,reg,root); try rmdir([fol.var '/tmp']); end
    cd(fol.reg);
    
    if (strcmp(par.ID,'t_mwv') || strcmp(par.ID,'PI')) && PI_ID == 4
          load('info_reg_GGOS.mat');
    else, load('info_reg.mat');
    end
    
    if (mod.ID == 5 && strcmp(par.ID,'PI')) || ...
        (mod.ID == 5 && strcmp(par.ID,'t_mwv')),rmdir(fol.var,'s');
    
        if     strcmp(par.ID,'PI'),    ID = era_PI_ID(PI_ID);
        elseif strcmp(par.ID,'t_mwv'), ID = era_Tm_ID(PI_ID);
        end
        
        fol.var = strrep(fol.var,par.ID,[ par.ID '_' ID.type ]);
        fol.raw = strrep(fol.raw,par.ID,[ par.ID '_' ID.type ]);
        fol.ana = strrep(fol.ana,par.ID,[ par.ID '_' ID.type ]);
        fol.img = strrep(fol.img,par.ID,[ par.ID '_' ID.type ]);
        
    end
    
    cd(fol.raw); fnc = dir('*.nc'); lnc = length(fnc);
    fprintf('\n');
    
    parfor jj = 1 : lnc, t = []; dt = [];
        
        [ ~,name,~ ] = fileparts(fnc(jj).name);
        yr = strsplit(name,'-'); yr = str2double(yr{end});
        
        tic; data   = eraa_ncextract(fnc,par,mod,jj); t(1) = toc;
        tic; dt.ysm = eraa_yrseamo(data,mod,reg,jj);
             dt.dhr = eraa_diurnal(data,mod,reg,jj);
             dt.var = eraa_variance(data,mod,reg,jj); t(2) = toc;
        tic; ncname = eraa_ncsave(dt,fnc,mod,reg,jj); t(3) = toc;
        
        fprintf(['Analysed %s data in the %s region data during %d\n' ...
                 '    Total Elapsed Time: %.2f sec\n' ...
                 '        Extraction: %.2f sec\n' ...
                 '        Processing and Analysis: %.2f sec\n' ...
                 '        Saving netCDF: %.2f sec\n\n' ], ...
                 par.name,reg.ID,yr,sum(t),t);
        
        movefile(ncname,fol.ana);
        
    end
    
    cd(root.era);
    
end
delete(pobj);

par.pre = pvec;
fprintf('\nAnalysis of data for the %s region completed!\n\n',reg.ID);

era_shutdown(logf,[fol.var '/ana']); clear all;
