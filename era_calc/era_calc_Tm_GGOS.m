function Tm_out = era_calc_Tm_GGOS (Tm_in,lon_G,lat_G,mlon,mlat)



nt = size(Tm_in,3); nlon = size(mlon,1); nlat = size(mlon,2);
Tm_out = zeros([nlon nlat nt]);

parfor ii = 1 : nt, Tmii = Tm_in(:,:,ii);
    try    Tm_out(:,:,ii) = interp2(lat_G,lon_G,Tmii,mlat,mlon,'makima');
    catch, Tm_out(:,:,ii) = NaN;
    end
end

end