function fol = era_PI_MEA(mod,par,reg,trange,root)



fol.reg = [ root.era '/' reg.ID ];                   mkfol(fol.reg);
fol.PI  = [ root.era '/' reg.ID '/' par.ID '_MEA' ]; mkfol(fol.PI);
fol.raw = [  fol.PI  '/raw' ];                       mkfol(fol.raw);
fol.img = [  fol.PI  '/img' ];                       mkfol(fol.img);
fol.ana = [  fol.PI  '/ana' ];                       mkfol(fol.ana);

lon = reg.lon; nlon = reg.size(1);
lat = reg.lat; nlat = reg.size(2); [ mlat,~ ] = meshgrid(lat,lon);

if mod.stp.ID == 1, era = 'era5'; else, era = 'erai'; end
ncoro = [ root.era '/' reg.ID '/z_sfc/raw/' era '-' reg.ID '-z_sfc.nc' ];
try    oro = mean(ncread(ncoro,'z')/9.81,3,'omitnan'); 
catch, oro = mean(ncread(ncoro,'z_sfc')/9.81,3,'omitnan'); 
end
oro(oro<0) = 0; cd(root.era);

fprintf('\n');

for yr = trange(1) : trange(2)
    
    pname = era_PI_MEA_ncname(mod,par,reg,yr);
    tic; PI = era_calc_PI_MN(mod,yr,mlat,oro); t(1) = toc;
    dim = {'lon',nlon,'lat',nlat,'t',size(PI,3)};
    
    tic; era_PI_save(pname,PI,reg,fol,dim); t(2) = toc;
    
    fprintf([ 'Calculated PI over %s region for %d:\n' ...
              '    Method: Manandhar et al. [2017]\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Calculating PI: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ], ...
              reg.ID,yr,sum(t),t(1),t(2));
    
end

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.PI);

end