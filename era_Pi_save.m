function era_Pi_save(pname,PI,reg,fol,dim)



nlon = reg.size(1); nlat = reg.size(2);

if exist(pname,'file') == 2, delete(pname); end

nccreate(pname,'PI','Dimensions',dim);
nccreate(pname,'longitude','Dimensions',{'lon',nlon});
nccreate(pname,'latitude','Dimensions',{'lat',nlat});

ncwrite(pname,'PI',PI);
ncwrite(pname,'longitude',reg.lon);
ncwrite(pname,'latitude',reg.lat);

movefile(pname,fol.raw);

end