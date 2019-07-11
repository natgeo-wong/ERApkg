%                                 erad.m
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

clear all; [ ini,root,logf ] = era_startup(1);
[ mod,par,trange,reg ] = era_initialize(ini);

fprintf('Proceeding to create download script(s) ...\n\n');

if ini.ID == 1, fol = erad5_script(mod,par,trange,reg,root);
else,           fol = eradi_script(mod,par,trange,reg,root);
end

era_shutdown(logf,[fol.var '/tmp']); clear all;