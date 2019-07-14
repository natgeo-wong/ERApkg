function fol = era_Pi_Tm2Pi (mod,par,reg,tvec,root,ID)



fol.reg = [ root.era '/' reg.ID ];                        mkfol(fol.reg);
fol.Pi  = [ root.era '/' reg.ID '/' par.ID '_' ID.type ]; mkfol(fol.Pi);
fol.raw = [  fol.Pi  '/raw' ];                            mkfol(fol.raw);
fol.img = [  fol.Pi  '/img' ];                            mkfol(fol.img);
fol.ana = [  fol.Pi  '/ana' ];                            mkfol(fol.ana);
fprintf('\n');

lon = reg.lon; lat = reg.lat; nlon = numel(lon); nlat = numel(lat);

TmID = era_Tm_ID(ID.ID); tpar.ID = 't_mwv';
fol.Tm  = [ root.era '/' reg.ID '/t_mwv_' TmID.type '/raw/' ]; cd(fol.Tm);

for yr = tvec(1) : tvec(2)
    
    if mod.stp.ID == 1, era = 'era5'; else, era = 'erai'; end
    tname = [ era '-' reg.ID '-t_mwv_' TmID.type '-sfc-' num2str(yr) '.nc' ];
    pname = [ era '-' reg.ID  '-Pi_'    ID.type  '-sfc-' num2str(yr) '.nc' ];
    tic; Tm = era_ncread(tname,tpar); t(1) = toc;
    tic; Pi = era_calc_Tm2Pi(Tm);        t(2) = toc;
    dim = {'lon',nlon,'lat',nlat,'t',size(Pi,3)};
    
    tic; era_Pi_save(pname,Pi,reg,fol,dim); t(3) = toc;
    
    fprintf([ 'Calculated Pi over %s region for %d:\n' ...
              '    Method: Askne and Nodius [1985], Tm %s\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Extracting Tm: %.2f sec\n' ...
              '        Calculating Pi: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ], ...
              reg.ID,yr,TmID.type,sum(t),t(1),t(2));
    
end

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.PI);

end