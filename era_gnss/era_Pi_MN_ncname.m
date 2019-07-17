function pname = era_Pi_MN_ncname (mod,par,reg,yr)



dset = mod.stp.ID;
if dset == 1, era = 'era5'; elseif dset == 2, era = 'erai'; end
pname = [ era '-' reg.ID '-' par.ID '_MN-sfc-' num2str(yr) '.nc' ];

end