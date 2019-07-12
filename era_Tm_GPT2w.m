function fol = era_Tm_GPT2w (mod,par,reg,tvec,root,ini)



%#ok<*AGROW>
%#ok<*PFBNS>

fol.reg = [ root.era '/' reg.ID ];                  mkfol(fol.reg);
fol.Tm  = [ root.era '/' reg.ID '/' par.ID '_G2' ]; mkfol(fol.Tm);
fol.raw = [  fol.Tm  '/raw' ];                      mkfol(fol.raw);
fol.img = [  fol.Tm  '/img' ];                      mkfol(fol.img);
fol.ana = [  fol.Tm  '/ana' ];                      mkfol(fol.ana);
fprintf('\n');

lon = reg.lon; lat = reg.lat; [ mlat,mlon ] = meshgrid(lat,lon);

fol.zbase = [ root.era '/' reg.ID '/z_sfc/raw/' ];
cd(fol.zbase); fzsfc = dir('*.nc'); fzsfc = [ fol.zbase fzsfc(1).name ];

try    z = mean(ncread(fzsfc,'z_sfc'),3,'omitnan');
catch, z = mean(ncread(fzsfc,'z'),3,'omitnan');
end

if isempty(gcp('nocreate')), pobj = parpool(31); end
for yr = tvec(1) : tvec(2)
    
    pname = [ era '-' reg.ID '-' par.ID '_G2-sfc-' num2str(yr) '.nc' ];
    
    tic; Tm = era_calc_Tm_GPT2w(mod,mlon,mlat,z,yr);  t(1) = toc;
    
    dim = {'lon',nlon,'lat',nlat,'t',size(Tm,3)};
    tic; era_Tm_save(pname,Tm,reg,fol,dim); t(2) = toc;
    
    fprintf([ 'Calculated Tm at surface over %s region for %d:\n' ...
              '    Method: GPT2w model (Bohm et al., 2015)\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Calculating Moisture Temperature: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ],...
              reg.ID,yr,sum(t),t(1),t(2));
    
end
delete(pobj);

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.PI);

end