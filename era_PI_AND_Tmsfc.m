function Tm_out = era_PI_AND_Tmsfc(Tm_in,z_air,Ts,reg,root)



dim = size(Tm_in); np = dim(4); dim(3:4) = []; nps = 25;

fol.zsfc = [ root.era '/' reg.ID '/z_sfc/raw/' ];
cd(fol.zsfc); fzsfc = dir('*.nc'); fzsfc = [ fol.zsfc fzsfc(1).name ];

try    z_sfc = mean(ncread(fzsfc,'z_sfc'),3,'omitnan');
catch, z_sfc = mean(ncread(fzsfc,'z'),3,'omitnan');
end

lon = reg.lon; lat = reg.lat; [ mlat,mlon ] = meshgrid(lat,lon);
mlon = mlon(:); mlat = mlat(:); z_sfc = z_sfc(:); npts = length(mlon);

% Assume hydrostatic balance in the atmosphere
z_37  = z_air(:,:,:,37);
z_38  = z_37 - 287.05 * (273.15 + Ts) * log(1.01235);
z_air = z_air(:,:,:,nps:37); Tm_in = Tm_in(:,:,:,nps:end);

if     np == 37, z = z_air(:);
elseif np == 38, z = [ z_air(:) ; z_38(:) ];
end

nlvl = np+1-nps; Tm_in = reshape(Tm_in,[],nlvl);
z = reshape(z,[],nlvl); Tm_out = zeros(npts,1);

for ii = 1 : npts, zii = z(ii,:); Tm_ii = Tm_in(ii,:); sfcii = z_sfc(ii);
    
    Tm_out(ii) = interp1(zii(:),Tm_ii(:),sfcii,'spline');
    
end

Tm_out = reshape(Tm_out,dim);

end