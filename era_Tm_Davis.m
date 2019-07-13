function fol = era_Tm_Davis (mod,par,reg,tvec,root,ini)



%#ok<*AGROW>
%#ok<*PFBNS>

fol.reg = [ root.era '/' reg.ID ];                  mkfol(fol.reg);
fol.Tm  = [ root.era '/' reg.ID '/' par.ID '_D' ];  mkfol(fol.Tm);
fol.raw = [  fol.Tm  '/raw' ];                      mkfol(fol.raw);
fol.img = [  fol.Tm  '/img' ];                      mkfol(fol.img);
fol.ana = [  fol.Tm  '/ana' ];                      mkfol(fol.ana);
fprintf('\n');

nlon = reg.size(1); nlat = reg.size(2);
p = era_pressure_load;

[ ~,tpar,~,~ ] = era_initialize(ini,2,4,0);
[ ~,hpar,~,~ ] = era_initialize(ini,4,2,0);
[ ~,zpar,~,~ ] = era_initialize(ini,2,5,0);
[ ~,spar,~,~ ] = era_initialize(ini,1,3,0);
fol.tbase = [ root.era '/' reg.ID '/' tpar.ID ];
fol.hbase = [ root.era '/' reg.ID '/' hpar.ID ];
fol.zbase = [ root.era '/' reg.ID '/' zpar.ID ];
    sbase = [ root.era '/' reg.ID '/' spar.ID '/raw/' ];

if isempty(gcp('nocreate')), pobj = parpool(31); end
for yr = tvec(1) : tvec(2)
    
    ii = yr - 1978; ndy = yeardays(yr); t = [];
    
    if mod.stp.ID == 1, era = 'era5'; nhr = 24 * ndy;
    else,               era = 'erai'; nhr = 4  * ndy;
    end
    
    pname = [ era '-' reg.ID '-' par.ID '_D-sfc-' num2str(yr) '.nc' ];
    if exist(pname,'file') == 2, delete(pname); end
    
    tic;
    Tm = zeros([ reg.size nhr ]);
    
    parfor tt = 1 : nhr, kk = 0;
    
        Ta = zeros([ reg.size 1 length(p) ]);
        sH = zeros([ reg.size 1 length(p) ]);
        za = zeros([ reg.size 1 length(p) ]);
        
        cd(sbase); snc = dir('*.nc'); sname = [sbase '/' snc(ii).name];
        cd(root.era); Ts = era_ncread(sname,spar,[1 1 tt],[Inf Inf 1]);
        
        for jj = p, pjj = num2str(jj); kk = kk + 1;
            
            tbase = [fol.tbase '/raw/' tpar.ID '-' pjj 'hPa'];
            hbase = [fol.hbase '/raw/' hpar.ID '-' pjj 'hPa'];
            zbase = [fol.zbase '/raw/' zpar.ID '-' pjj 'hPa'];
            
            cd(tbase); tnc = dir('*.nc'); tname = [tbase '/' tnc(ii).name];
            cd(hbase); hnc = dir('*.nc'); hname = [hbase '/' hnc(ii).name];
            cd(zbase); znc = dir('*.nc'); zname = [zbase '/' znc(ii).name];
            cd(root.era);
            
            Ta(:,:,:,kk) = era_ncread(tname,tpar,[1 1 tt],[Inf Inf 1]);
            sH(:,:,:,kk) = era_ncread(hname,hpar,[1 1 tt],[Inf Inf 1]);
            za(:,:,:,kk) = era_ncread(zname,zpar,[1 1 tt],[Inf Inf 1]);
            
        end
        
        cd(root.era);
        Tm_pre = era_calc_Tm_Davis(Ta,sH,p,Ts);
        Tm(:,:,tt) = era_calc_Tm_pre2sfc(Tm_pre,za,Ts,reg,root);
        
    end
    
    cd(root.era); dim = {'lon',nlon,'lat',nlat,'t',size(Tm,3)};
    tic; era_Tm_save(pname,Tm,reg,fol,dim); t(2) = toc;
    
    fprintf([ 'Calculated Tm at surface over %s region for %d:\n' ...
              '    Method: Davis et al. [1985]\n' ...
              '    Total Elapsed Time: %.2f sec\n' ...
              '        Extraction and Calculation: %.2f sec\n' ...
              '        Save netCDF: %.2f sec\n\n' ], ...
              reg.ID,yr,sum(t),t);
    
end
delete(pobj);

save('info_par.mat','mod','par','root');
movefile('info_par.mat',fol.Tm);

end