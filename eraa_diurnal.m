function dhr = eraa_diurnal (data,mod,reg,yrjj)

% script calculates the year,month and seasonal stats for each individual
% time in the day

nlon = reg.size(1); nlat = reg.size(2);

if mod.stp.ID == 1, dh = 1; else, dh = 6; end; nh = 24/dh;
dt = datenum(yrjj-1,1,1) : datenum(yrjj+1,1,1);
dt(end) = []; [ yr,mo,~,~,~,~ ] = datevec(dt);
data = reshape(data,nlon,nlat,24/dh,[]);

yrdata = data(:,:,:,yr==yrjj);
yrmn = mean(yrdata,4); yrsd = std(yrdata,[],4);
yrrg = max(yrdata,[],4) - min(yrdata,[],4);

momn = zeros(nlon,nlat,nh,12); mosd  = zeros(nlon,nlat,nh,12);
morg = zeros(nlon,nlat,nh,12);

for ii = 1 : 12, ind = yr==yrjj & mo==ii;
    momn(:,:,:,ii) = mean(data(:,:,:,ind),4);
    mosd(:,:,:,ii) = std(data(:,:,:,ind),[],4);
    morg(:,:,:,ii) = max(data(:,:,:,ind),[],4) - min(data(:,:,:,ind),[],4);
end

data(:,:,:,yr==yrjj & mo==12) = data(:,:,:,yr==yrjj-1 & mo==12);
data(:,:,:,yr~=yrjj) = []; mo(yr~=yrjj) = [];

ssmn = zeros(nlon,nlat,nh,4); sssd  = zeros(nlon,nlat,nh,4);
ssrg = zeros(nlon,nlat,nh,4);

for ii = 1 : 4, mvec = dnt_sea2mon(ii); [ ~,ind,~ ] = intersect(mo,mvec);
    ssmn(:,:,:,ii) = mean(data(:,:,:,ind),4);
    sssd(:,:,:,ii) = std(data(:,:,:,ind),[],4);
    ssrg(:,:,:,ii) = max(data(:,:,:,ind),[],4) - min(data(:,:,:,ind),[],4);
end

dhr.yr.mn = yrmn; dhr.yr.sd = yrsd; dhr.yr.rng = yrrg;
dhr.ss.mn = ssmn; dhr.ss.sd = sssd; dhr.ss.rng = ssrg;
dhr.mo.mn = momn; dhr.mo.sd = mosd; dhr.mo.rng = morg;

end