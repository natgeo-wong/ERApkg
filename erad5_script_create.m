function [ fname,fID ] = erad5_script_create (par,reg)



if ~isnan(par.pre), lvl = sprintf('%dhPa',par.pre);
else,               lvl = 'sfc';
end

fname = [ 'era5-' reg.ID '-' par.ID '-' lvl ];
fID = fopen([ fname '.py' ],'w');

fprintf(1,'Creating download script %s.py ... ',fname);

fprintf(fID,'#!/usr/bin/env python\n');
fprintf(fID,'import cdsapi\n');
fprintf(fID,'c = cdsapi.Client()\n\n');

end