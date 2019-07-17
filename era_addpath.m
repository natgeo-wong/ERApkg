function era_addpath



if exist('/home/nwong002/reanalysis','dir') == 7
      cbase = '/home/nwong002/codes/ERApkg/';
else, cbase = '~/codes/ERApkg/';
end
addpath(genpath(cbase));

crun = [ cbase '/run/' ]; rmpath(crun);

end