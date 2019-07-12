function ysm = eraa_yrseamo (data,mod,reg,yrjj)

% script calculates the variability for the year, month and season,
% excluding the effects of the diurnal cycle, which means that we are
% calculating based on daily stats

nlon = reg.size(1); nlat = reg.size(2);

if mod.stp.ID == 1, dh = 1; else, dh = 6; end
dt = datenum(yrjj-1,1,1) : datenum(yrjj+1,1,1);
dt(end) = []; [ yr,mo,~,~,~,~ ] = datevec(dt);
data = reshape(data,nlon,nlat,24/dh,[]); data = mean(data,3);
data = reshape(data,nlon,nlat,[]);

yrdata = data(:,:,yr==yrjj);
yrmn = mean(yrdata,3); yrsd = std(yrdata,[],3);
yrrg = max(yrdata,[],3) - min(yrdata,[],3);

momn = zeros(nlon,nlat,12); mosd  = zeros(nlon,nlat,12);
morg = zeros(nlon,nlat,12);

for ii = 1 : 12, ind = yr==yrjj & mo==ii;
    momn(:,:,ii) = mean(data(:,:,ind),3);
    mosd(:,:,ii) = std(data(:,:,ind),[],3);
    morg(:,:,ii) = max(data(:,:,ind),[],3) - min(data(:,:,ind),[],3);
end

data(:,:,yr==yrjj & mo==12) = data(:,:,yr==yrjj-1 & mo==12);
data(:,:,yr~=yrjj) = []; mo(yr~=yrjj) = [];

ssmn = zeros(nlon,nlat,4); sssd  = zeros(nlon,nlat,4);
ssrg = zeros(nlon,nlat,4);

for ii = 1 : 4, mvec = dnt_sea2mon(ii); [ ~,ind,~ ] = intersect(mo,mvec);
    ssmn(:,:,ii) = mean(data(:,:,ind),3);
    sssd(:,:,ii) = std(data(:,:,ind),[],3);
    ssrg(:,:,ii) = max(data(:,:,ind),[],3) - min(data(:,:,ind),[],3);
end

ysm.yr.mn = yrmn; ysm.yr.sd = yrsd; ysm.yr.rng = yrrg;
ysm.ss.mn = ssmn; ysm.ss.sd = sssd; ysm.ss.rng = ssrg;
ysm.mo.mn = momn; ysm.mo.sd = mosd; ysm.mo.rng = morg;

end