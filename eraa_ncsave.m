function ncname = eraa_ncsave (dt,fnc,mod,reg,jj)



nlon = reg.size(1); nlat = reg.size(2); dim = {'lon',nlon,'lat',nlat};
ncname = fnc(jj).name; ncname = strrep(ncname,'era','eraa');
if mod.stp.ID == 1, nhr = 24; elseif mod.stp.ID == 2, nhr = 4; end

if exist(ncname,'file') == 2, delete(ncname); end

nccreate(ncname,'longitude','Dimensions',{'lon',nlon});
nccreate(ncname,'latitude','Dimensions',{'lat',nlat});

nccreate(ncname,'raw_year_mu','Dimensions',dim);
nccreate(ncname,'raw_year_sig','Dimensions',dim);
nccreate(ncname,'raw_year_rng','Dimensions',dim);

nccreate(ncname,'raw_month_mu','Dimensions',[dim,{'mon',12}]);
nccreate(ncname,'raw_month_sig','Dimensions',[dim,{'mon',12}]);
nccreate(ncname,'raw_month_rng','Dimensions',[dim,{'mon',12}]);

nccreate(ncname,'raw_season_mu','Dimensions',[dim,{'sea',4}]);
nccreate(ncname,'raw_season_sig','Dimensions',[dim,{'sea',4}]);
nccreate(ncname,'raw_season_rng','Dimensions',[dim,{'sea',4}]);

nccreate(ncname,'diurnal_year_mu','Dimensions',[dim,{'hr',nhr}]);
nccreate(ncname,'diurnal_year_sig','Dimensions',[dim,{'hr',nhr}]);
nccreate(ncname,'diurnal_year_rng','Dimensions',[dim,{'hr',nhr}]);

nccreate(ncname,'diurnal_month_mu','Dimensions',[dim,{'hr',nhr,'mon',12}]);
nccreate(ncname,'diurnal_month_sig','Dimensions',[dim,{'hr',nhr,'mon',12}]);
nccreate(ncname,'diurnal_month_rng','Dimensions',[dim,{'hr',nhr,'mon',12}]);

nccreate(ncname,'diurnal_season_mu','Dimensions',[dim,{'hr',nhr,'sea',4}]);
nccreate(ncname,'diurnal_season_sig','Dimensions',[dim,{'hr',nhr,'sea',4}]);
nccreate(ncname,'diurnal_season_rng','Dimensions',[dim,{'hr',nhr,'sea',4}]);

nccreate(ncname,'variance_year_mu','Dimensions',dim);
nccreate(ncname,'variance_year_sig','Dimensions',dim);
nccreate(ncname,'variance_year_rng','Dimensions',dim);

nccreate(ncname,'variance_month_mu','Dimensions',[dim,{'mon',12}]);
nccreate(ncname,'variance_month_sig','Dimensions',[dim,{'mon',12}]);
nccreate(ncname,'variance_month_rng','Dimensions',[dim,{'mon',12}]);

nccreate(ncname,'variance_season_mu','Dimensions',[dim,{'sea',4}]);
nccreate(ncname,'variance_season_sig','Dimensions',[dim,{'sea',4}]);
nccreate(ncname,'variance_season_rng','Dimensions',[dim,{'sea',4}]);

ncwrite(ncname,'longitude',reg.lon); ncwrite(ncname,'latitude',reg.lat);

ncwrite(ncname,'raw_year_mu',dt.ysm.yr.mn);
ncwrite(ncname,'raw_year_sig',dt.ysm.yr.sd);
ncwrite(ncname,'raw_year_rng',dt.ysm.yr.rng);

ncwrite(ncname,'raw_month_mu',dt.ysm.mo.mn);
ncwrite(ncname,'raw_month_sig',dt.ysm.mo.sd);
ncwrite(ncname,'raw_month_rng',dt.ysm.mo.rng);

ncwrite(ncname,'raw_season_mu',dt.ysm.ss.mn);
ncwrite(ncname,'raw_season_sig',dt.ysm.ss.sd);
ncwrite(ncname,'raw_season_rng',dt.ysm.ss.rng);

ncwrite(ncname,'diurnal_year_mu',dt.dhr.yr.mn);
ncwrite(ncname,'diurnal_year_sig',dt.dhr.yr.sd);
ncwrite(ncname,'diurnal_year_rng',dt.dhr.yr.rng);

ncwrite(ncname,'diurnal_month_mu',dt.dhr.mo.mn);
ncwrite(ncname,'diurnal_month_sig',dt.dhr.mo.sd);
ncwrite(ncname,'diurnal_month_rng',dt.dhr.mo.rng);

ncwrite(ncname,'diurnal_season_mu',dt.dhr.ss.mn);
ncwrite(ncname,'diurnal_season_sig',dt.dhr.ss.sd);
ncwrite(ncname,'diurnal_season_rng',dt.dhr.ss.rng);

ncwrite(ncname,'variance_year_mu',dt.var.yr.mn);
ncwrite(ncname,'variance_year_sig',dt.var.yr.sd);
ncwrite(ncname,'variance_year_rng',dt.var.yr.rng);

ncwrite(ncname,'variance_month_mu',dt.var.mo.mn);
ncwrite(ncname,'variance_month_sig',dt.var.mo.sd);
ncwrite(ncname,'variance_month_rng',dt.var.mo.rng);

ncwrite(ncname,'variance_season_mu',dt.var.ss.mn);
ncwrite(ncname,'variance_season_sig',dt.var.ss.sd);
ncwrite(ncname,'variance_season_rng',dt.var.ss.rng);

end