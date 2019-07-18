function [ ini,root,logf ] = era_startup (actID,dID)



close all; clc; era_addpath; ntxt = length(dir('*.txt'));
ftxt = [ 'log' num2str(ntxt+1) '.txt' ];
root = era_root; diary(ftxt); logf = [ pwd '/' ftxt ];

fprintf('Log record started at %s\n\n',datestr(now));
type era_welcome.txt; disp(' ');

if nargin == 2, dset = era_startup_dataset(dID); 
else,           dset = era_startup_dataset;
end; ini = dset; 

act  = era_startup_act(actID); ini.act = act.ID; ini.actstr = act.name;

fprintf('You have chosen to %s %s data.\n\n',act.name,ini.name);

if     ini.ID == 1, root.era = root.era5;
elseif ini.ID == 2, root.era = root.erai;
end

cd(root.era); root.era5 = []; root.erai = [];

end