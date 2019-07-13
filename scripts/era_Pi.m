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

clear all; [ ini,root,logf ] = era_startup(2,2);
[ mod,par,trange,reg ] = era_initialize(ini,5,3,1);

fprintf('Proceeding to run PI script ...\n\n'); ID = era_PI_ID(2);

if     ID.ID == 1, fol = era_PI_AND(mod,par,reg,trange,root,ini);
elseif ID.ID == 2, fol = era_PI_ANB(mod,par,reg,root,ini);
elseif ID.ID == 3, fol = era_PI_MEA(mod,par,reg,trange,root);
end

era_shutdown(logf,fol.raw); clear all;
