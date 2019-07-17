function Tm = era_calc_Tm_GPT2w (mod,mlon,mlat,z,yr)



if mod.stp.ID == 2, hr = 6; else, hr = 1; end
dt = datenum(yr,1,1) : datenum(0,0,0,hr,0,0) : datenum(yr+1,1,1);
dt(end) = []; nt = numel(dt); Tm = zeros([size(mlon) nt]);
dt = datetime(dt,'convertfrom','datenum'); jd = juliandate(dt);
dim = size(Tm); Tm = reshape(Tm,[],nt); nst = dim(1) * dim(2);
mlon = mlon(:) * pi / 180; mlat = mlat(:) * pi / 180; z = z(:);

parfor ii = 1 : nt, jdii = jd(ii);
    [ ~,~,~,Tm(:,ii),~,~,~,~,~ ] = era_GPT2w(jdii,mlat,mlon,z,nst,0);
end

Tm = reshape(Tm,dim);

end