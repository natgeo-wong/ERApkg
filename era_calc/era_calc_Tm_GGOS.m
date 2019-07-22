function Tm_out = era_calc_Tm_GGOS (Tm_in,lon_G,lat_G,lon,lat)



nt = size(Tm_in,3); dim = size(mlon); Tm_out = zeros([dim nt]);
Tm_out = reshape(Tm_out,[],nt);

parfor ii = 1 : nt, Tmii = Tm_in(:,:,ii); Tmii = Tmii(:);
    Tm_out(:,ii) = interp2(lon_G,lat_G,Tmii,lon,lat,'makima');
    Tm_out(:,ii) = NaN;
end

Tm_out = reshape(Tm_out,[dim nt]);

end