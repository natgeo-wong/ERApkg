function fol = era_Tm_GGOS (mod,par,reg,tvec,root)



%#ok<*AGROW>
%#ok<*PFBNS>

fol.reg = [ root.era '/' reg.ID ];                  mkfol(fol.reg);
fol.Tm  = [ root.era '/' reg.ID '/' par.ID '_GA' ]; mkfol(fol.Tm);
fol.tmp = [  fol.Tm  '/tmp' ];                      mkfol(fol.tmp);
fol.raw = [  fol.Tm  '/raw' ];                      mkfol(fol.raw);
fol.img = [  fol.Tm  '/img' ];                      mkfol(fol.img);
fol.ana = [  fol.Tm  '/ana' ];                      mkfol(fol.ana);
fprintf('\n');

lon = reg.lon; lat = reg.lat; lat = -lat;
[ mlat,mlon ] = meshgrid(lat,lon);
nlon = numel(lon); nlat = numel(lat);

if isempty(gcp('nocreate')), pobj = parpool(31); end
for yr = tvec(1) : tvec(2)
    
    if mod.stp.ID == 1, era = 'era5'; else, era = 'erai'; end
    gname = [ 'GGOS-' reg.ID '-' par.ID '_GA-sfc-' num2str(yr) '.nc' ];
    tname = [ era '-' reg.ID '-' par.ID '_GA-sfc-' num2str(yr) '.nc' ];
    
    cd(fol.tmp); tic;
    Tm    = era_ncread(gname,par);
    lon_G = ncread(gname,'longitude');
    lat_G = ncread(gname,'latitude'); lat_G = -lat_G; t(1) = toc;

    tic; Tm = era_calc_Tm_GGOS(Tm,lon_G,lat_G,mlon,mlat); t(2) = toc;
    
    dim = {'lon',nlon,'lat',nlat,'t',size(Tm,3)};
    tic; era_Tm_save(tname,Tm,reg,fol,dim); t(3) = toc;
    
    fprintf([ 'Calculated Tm at surface over %s region for %d:\n' ...
              '    Method: GGOS Atmosphere model (Bohm & Schuh, 2013)\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Extracting Moisture Temperature: %.2f sec\n' ...
              '        Regridding to required resolution: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ],...
              reg.ID,yr,sum(t),t(1),t(2),t(3));
    
end
delete(pobj);

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.Tm);

end