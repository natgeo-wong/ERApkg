function Tm = era_calc_Tm_Davis_zd (p,Ta,Ts,Td,sH,za,zs)



Rd = 287.05; Rv = 461.51; ep = Rd / Rv;
p = reshape(p,1,1,1,[]);
e = p .* sH ./ ((1-sH)*ep + sH); e38 = era_calc_Td2e(Td);
Ta = cat(4,Ta,Ts); za = cat(4,za,zs); e = cat(4,e,e38);

p(end+1) = 1012.35; np = size(p,4);
top = e ./ Ta; bot = e ./ Ta.^2; dim = size(top); Tm = zeros(dim);
top = reshape(top,[],np)'; bot = reshape(bot,[],np)';
za = reshape(za,[],np)'; Tm = reshape(Tm,[],np)'; npt = size(Tm,1);

for ii = 1 : npt
    zai = za(:,ii); ti = top(:,ii); bi = bot(:,ii);
    Tm(:,ii) = cumtrapz(zai,ti,1) ./ cumtrapz(zai,bi,1);
end

Tm = reshape(Tm,dim);

end