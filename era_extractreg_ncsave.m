function era_extractreg_ncsave(ncname,data,par,reg)



nlon = reg.size(1); nlat = reg.size(2);
dim = {'lon',nlon,'lat',nlat,'t',size(data,3)};

if exist(ncname,'file') == 2, delete(ncname); end

nccreate(ncname,par.ID,'Dimensions',dim);
nccreate(ncname,'longitude','Dimensions',{'lon',nlon});
nccreate(ncname,'latitude','Dimensions',{'lat',nlat});

ncwrite(ncname,par.ID,data);
ncwrite(ncname,'longitude',reg.lon);
ncwrite(ncname,'latitude',reg.lat);

end