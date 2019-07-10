function nc = era_region_nc(reg,dwn)



rgrid = reg.grid; dgrid = dwn.reg.grid; nc.step = [1 1 1];
if all(rgrid == dgrid)
    nc.beg = [ 1 1 1 ]; nc.fin = [ Inf Inf Inf ];
else
    rN = rgrid(1); rS = rgrid(3); dlat = dwn.reg.lat;
    rW = rgrid(2); rE = rgrid(4); dlon = dwn.reg.lon;
    [ ~,blat ] = min(abs(dlat-rN)); [ ~,elat ] = min(abs(dlat-rS));
    [ ~,blon ] = min(abs(dlon-rW)); [ ~,elon ] = min(abs(dlon-rE));
    nc.beg = [ blon blat 1 ]; nc.fin = [ elon elat Inf ] - nc.beg + 1;
end

end