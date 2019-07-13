function fol = era_Tm_GTm3 (mod,par,reg,tvec,root)



%#ok<*AGROW>
%#ok<*PFBNS>

fol.reg = [ root.era '/' reg.ID ];                  mkfol(fol.reg);
fol.Tm  = [ root.era '/' reg.ID '/' par.ID '_GT' ];  mkfol(fol.Tm);
fol.raw = [  fol.Tm  '/raw' ];                      mkfol(fol.raw);
fol.img = [  fol.Tm  '/img' ];                      mkfol(fol.img);
fol.ana = [  fol.Tm  '/ana' ];                      mkfol(fol.ana);
fprintf('\n');

lon = reg.lon; lat = reg.lat; [ mlon,mlat ] = meshgrid(lon,lat);

for yr = tvec(1) : tvec(2)
    
    tname = [ era '-' reg.ID '-' par.ID '_GT-sfc-' num2str(yr) '.nc' ];
    
    tic; Tm = era_calc_Tm_GTm3(mlon,mlat,yr);  t(2) = toc;
    
    dim = {'lon',nlon,'lat',nlat,'t',size(PI,3)};
    tic; era_Tm_save(tname,Tm,reg,fol,dim); t(4) = toc;
    
    fprintf([ 'Calculated Tm at surface over %s region for %d:\n' ...
              '    Method: GTm-III model (Yao et al., 2014)\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Calculating Moisture Temperature: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ],...
              reg.ID,yr,sum(t),t(1),t(2),t(3),t(4));
    
end

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.PI);

end