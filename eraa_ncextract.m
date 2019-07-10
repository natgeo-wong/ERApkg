function data = eraa_ncextract (fnc,par,mod,jj)



nh = 24; if mod.stp.ID == 2, nh = 4; end; nh = yeardays(1978+jj-1) * nh;

d1 = era_ncread(fnc(jj).name,par); dim = size(d1);

if jj ~= 1, d2 = era_ncread(fnc(jj-1).name,par);
else,       d2 = ones([dim(1) dim(2) nh]) * NaN;
end

data = cat(3,d2,d1);

end