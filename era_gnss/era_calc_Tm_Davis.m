function Tm = era_calc_Tm_Davis (Ta,sH,p,Ts)



Rd = 287.05; Rv = 461.51; ep = Rd / Rv;
p(end+1) = 1012.35; p = reshape(p,1,1,1,[]);
Ta = cat(4,Ta,Ts); sH = cat(4,sH,sH(:,:,:,37));
e = p .* ((1-sH) ./ (1-sH + sH/ep)); cnv = p ./ Ta;

top = cnv .* e ./ Ta; bot = cnv .* e ./ Ta.^2;

p = p(:); top = cumtrapz(p,top,4); bot = cumtrapz(p,bot,4); Tm = top./bot;

end