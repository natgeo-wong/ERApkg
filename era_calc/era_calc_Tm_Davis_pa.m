function Tm = era_calc_Tm_Davis_pa (p,Ta,Ts,sH)



Rd = 287.05; Rv = 461.51; ep = Rd / Rv;
p(end+1) = 1012.35; p = reshape(p,1,1,1,[]);
Ta = cat(4,Ta,Ts); sH = cat(4,sH,sH(:,:,:,37));
e = p .* sH ./ ((1-sH)*ep + sH);

top = e ./ p; bot = e ./ (p .* Ta);

p = p(:); top = cumtrapz(p,top,4); bot = cumtrapz(p,bot,4); Tm = top./bot;

end