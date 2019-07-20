%                                era_PI.m
%          Script to find PI constant that transforms ZWD to PWV
%                          Nathanael Wong Zhixin
%
% This script finds the PI constant that transforms Zenith Wet Delay (ZWD)
% to Precipitatable Water Vapour (PWV) as found by Askne and Nodius 1997.
%
% The PI constant can be found via two methods:
% - Askne and Nodius [1997], where Tm is given by Davis et al. [1985]
% - Askne and Nodius [1997], where Tm is given by Bevis et al. [1992]
% - Manandhar et al. [2017]

clear all; era_addpath;
[ ini,root,logf ] = era_startup(2,2);
[ mod,par,tvec,reg ] = era_initialize(ini,5,3,1);

fprintf('Proceeding to run Pi script ...\n\n'); ID = era_Pi_ID(2);

if any(ID.ID == 1:9), fol = era_Pi_Tm2Pi(mod,par,reg,tvec,root,ID);
elseif ID.ID == 10,   fol = era_Pi_MN(mod,par,reg,tvec,root);
end

era_shutdown(logf,fol.raw); clear all;
