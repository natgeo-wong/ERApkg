function fol = era_Pi_MN (mod,par,reg,trange,root)



fol.reg = [ root.era '/' reg.ID ];                  mkfol(fol.reg);
fol.Pi  = [ root.era '/' reg.ID '/' par.ID '_MN' ]; mkfol(fol.Pi);
fol.raw = [  fol.Pi  '/raw' ];                      mkfol(fol.raw);
fol.img = [  fol.Pi  '/img' ];                      mkfol(fol.img);
fol.ana = [  fol.Pi  '/ana' ];                      mkfol(fol.ana);

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
    
    pname = era_Pi_MN_ncname(mod,par,reg,yr);
    tic; Pi = era_calc_Pi_MN(mod,yr,mlat,oro); t(1) = toc;
    dim = {'lon',nlon,'lat',nlat,'t',size(Pi,3)};
    
    tic; era_Pi_save(pname,Pi,reg,fol,dim);    t(2) = toc;
    
    fprintf([ 'Calculated Pi over %s region for %d:\n' ...
              '    Method: Manandhar et al. [2017]\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Calculating Pi: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ], ...
              reg.ID,yr,sum(t),t(1),t(2));
    
end

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.Pi);

end