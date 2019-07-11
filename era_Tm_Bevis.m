function fol = era_Tm_Bevis (mod,par,reg,tvec,root,ini,ID)



ID = era_Tm_ID(ID);

fol.reg = [ root.era '/' reg.ID ];                        mkfol(fol.reg);
fol.Tm  = [ root.era '/' reg.ID '/' par.ID '_' ID.type ]; mkfol(fol.Tm);
fol.raw = [  fol.Tm  '/raw' ];                            mkfol(fol.raw);
fol.img = [  fol.Tm  '/img' ];                            mkfol(fol.img);
fol.ana = [  fol.Tm  '/ana' ];                            mkfol(fol.ana);

nlon = reg.size(1); nlat = reg.size(2);

[ ~,tpar,~,~ ] = era_initialize(ini,1,3,0);

fol.tbase = [ root.era '/' reg.ID '/' tpar.ID '/raw' ]; cd(fol.tbase);
tnc = dir('*.nc'); cd(root.era);
fprintf('\n');

for yr = tvec(1) : tvec(2), ii = yr - 1978;
    
    tname = [fol.tbase '/' tnc(ii).name];
    pname = strrep(tnc(ii).name,tpar.ID,[par.ID '_' ID.type]);
    if exist(pname,'file') == 2, delete(pname); end
    
    tic; Ts = era_ncread(tname,tpar);           t(1) = toc;
    tic; Tm = era_calc_Tm_Bevis(Ts,ID.ID,reg);  t(2) = toc;
    
    dim = {'lon',nlon,'lat',nlat,'t',size(PI,3)};
    tic; era_Tm_save(pname,Tm,reg,fol,dim);     t(3) = toc;
    
    fprintf([ 'Calculated Tm at surface over %s region for %d:\n' ...
              '    Method: Bevis et al. [1985]\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Extracting Surface Temperature: %.2f sec\n' ...
              '        Calculating Moisture Temperature: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ],...
              reg.ID,yr,sum(t),t(1),t(2),t(3));
    
end

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.PI);

end