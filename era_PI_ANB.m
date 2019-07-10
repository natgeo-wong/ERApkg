function fol = era_PI_ANB(mod,par,reg,root,ini)



fol.reg = [ root.era '/' reg.ID ];                   mkfol(fol.reg);
fol.PI  = [ root.era '/' reg.ID '/' par.ID '_ANB' ]; mkfol(fol.PI);
fol.raw = [  fol.PI  '/raw' ];                       mkfol(fol.raw);
fol.img = [  fol.PI  '/img' ];                       mkfol(fol.img);
fol.ana = [  fol.PI  '/ana' ];                       mkfol(fol.ana);

nlon = reg.size(1); nlat = reg.size(2);

[ ~,tpar,~,~ ] = era_initialize(ini,1,3,0);

fol.tbase = [ root.era '/' reg.ID '/' tpar.ID '/raw' ]; cd(fol.tbase);
tnc = dir('*.nc'); lnc = length(tnc); cd(root.era);
fprintf('\n');

for ii = 1 : lnc, yr = ii + 1978;
    
    tname = [fol.tbase '/' tnc(ii).name];
    pname = strrep(tnc(ii).name,tpar.ID,[par.ID '_ANB']);
    if exist(pname,'file') == 2, delete(pname); end
    
    tic; Ts = era_ncread(tname,tpar); t(1) = toc;
    tic; Tm = era_calc_Tm_Bevis(Ts);  t(2) = toc;
    tic; PI = era_calc_PI_AN(Tm);     t(3) = toc;
    dim = {'lon',nlon,'lat',nlat,'t',size(PI,3)};
    
    tic; era_PI_save(pname,PI,reg,fol,dim); t(4) = toc;
    
    fprintf([ 'Calculated PI over %s region for %d:\n' ...
              '    Method: Askne and Nodius [1997], Bevis [1985]\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Extracting Surface Temperature: %.2f sec\n' ...
              '        Calculating Moisture Temperature: %.2f sec\n' ...
              '        Calculating PI: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ],...
              reg.ID,yr,sum(t),t(1),t(2),t(3),t(4));
    
end

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.PI);

end