function Tm_out = era_calc_Tm_pre2sfc(Tm_in,z_air,z_sfc,reg)



dim = size(Tm_in); np = dim(4); dim(3:4) = []; nps = 25;
npts = reg.size(1) * reg.size(2); z_sfc = z_sfc(:);

% Assume hydrostatic balance in the atmosphere
z_37  = z_air(:,:,:,37);
z_38  = z_sfc; z_38(z_38>z_37) = 0;
z_air = z_air(:,:,:,nps:37); Tm_in = Tm_in(:,:,:,nps:end);

if     np == 37, z = z_air(:);
elseif np == 38, z = [ z_air(:) ; z_38(:) ];
end

nlvl = np+1-nps; Tm_in = reshape(Tm_in,[],nlvl);
z = reshape(z,[],nlvl); Tm_out = zeros(npts,1);

for ii = 1 : npts, zii = z(ii,:); Tm_ii = Tm_in(ii,:); sfcii = z_sfc(ii);
    
    Tm_out(ii) = interp1(zii(:),Tm_ii(:),sfcii,'makima');
    
end

Tm_out = reshape(Tm_out,dim);

end