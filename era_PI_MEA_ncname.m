function pname = era_PI_MEA_ncname (mod,par,reg,yr)



dset = mod.stp.ID;
if dset == 1, era = 'era5'; elseif dset == 2, era = 'erai'; end
pname = [ era '-' reg.ID '-' par.ID '_MEA-sfc-' num2str(yr) '.nc' ];

end