function Tm_out = era_calc_Tm_GGOS (Tm_in,lon_G,lat_G,lon,lat)



nt = size(Tm_in,3); nlon = numel(lon); nlat = numel(lat);
Tm_out = zeros([nlon nlat nt]); Tm_out = reshape(Tm_out,[],nt);

parfor ii = 1 : nt, Tmii = Tm_in(:,:,ii);
    Tm_out(:,ii) = interp2(lat_G,lon_G,Tmii,lat,lon,'makima');
    %Tm_out(:,ii) = NaN;
end

Tm_out = reshape(Tm_out,[nlon nlat nt]);

end