function Tm = era_calc_Tm_Davis_pd (p,Ta,Ts,Td,sH)



Rd = 287.05; Rv = 461.51; ep = Rd / Rv;
p(end+1) = 1012.35; p = reshape(p,1,1,1,[]);
e = p .* sH ./ ((1-sH)*ep + sH); e38 = era_calc_Td2e(Td);
Ta = cat(4,Ta,Ts); e = cat(4,e,e38);

top = e ./ p; bot = e ./ (p .* Ta);

p = p(:); top = cumtrapz(p,top,4); bot = cumtrapz(p,bot,4); Tm = top./bot;

end