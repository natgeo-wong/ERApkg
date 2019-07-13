function Tm_out = era_calc_Tm_GGOS (Tm_in,mlon_G,mlat_G,mlon,mlat)



nt = size(Tm_in,3); dim = size(mlon); Tm_out = zeros([dim nt]);
Tm_out = reshape(Tm_out,[],nt);

mlon_G = mlon_G(:); mlat_G = mlat_G(:); mlon = mlon(:); mlat = mlat(:);

parfor ii = 1 : nt, Tmii = Tm_in(:,:,ii);
    Tm_out(:,ii) = interp2(mlon_G,mlat_G,Tmii(:),mlon,mlat)
end

Tm_out = reshape(Tm_out,[dim nt]);

end