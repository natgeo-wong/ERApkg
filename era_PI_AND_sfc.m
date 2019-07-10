function PI_out = era_PI_AND_sfc(PI_in,za,reg,root)



dim = size(PI_in); PI_out = zeros(dim(1:3)); t = dim(3); dim(3:4) = [];

fol.zsfc = [ root.era '/' reg.ID '/z_sfc/raw/' ];
cd(fol.zsfc); fzsfc = dir('*.nc'); fzsfc = [ fol.zsfc fzsfc(1).name ];
z_sfc = mean(ncread(fzsfc,'z_sfc'),3,'omitnan');

lon = reg.lon; lat = reg.lat; [ mlon,mlat ] = meshgrid(lon,lat);
outgrid = [ mlon(:) mlat(:) z_sfc(:) ];

for ii = 1 : t, z_air = za(:,:,ii,:);
    
    ingrid = [ repmat(mlon(:),37,1) repmat(mlat(:),37,1) z_air(:) ];
    PI_tii = PI_in(:,:,ii,:); PI_tii = reshape(PI_tii,[],1);
    F = scatteredInterpolant(ingrid,PI_tii); F.Method = 'natural';
    PI_tii = F(outgrid); PI_out(:,:,ii) = reshape(PI_tii,dim);
    
end

end