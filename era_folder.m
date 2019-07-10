function fol = era_folder (par,reg,root)



p = par.pre; fol.reg = [ root.era '/' reg.ID ]; mkfol(fol.reg);

if ~isnan(p), lvl = sprintf('%dhPa',p); else, lvl = 'sfc'; end
fol.var = [ root.era '/' reg.ID '/' par.ID ]; mkfol(fol.var);

if ~isnan(p)
    fol.raw = [ fol.var '/raw/' par.ID '-' lvl ]; mkfol(fol.raw);
    fol.tmp = [ fol.var '/tmp/' par.ID '-' lvl ]; mkfol(fol.tmp);
    fol.ana = [ fol.var '/ana/' par.ID '-' lvl ]; mkfol(fol.ana);
    fol.img = [ fol.var '/img/' par.ID '-' lvl ]; mkfol(fol.img);
else
    fol.raw = [ fol.var '/raw' ]; mkfol(fol.raw);
    fol.tmp = [ fol.var '/tmp' ]; mkfol(fol.tmp);
    fol.ana = [ fol.var '/ana' ]; mkfol(fol.ana);
    fol.img = [ fol.var '/img' ]; mkfol(fol.img);
end

end