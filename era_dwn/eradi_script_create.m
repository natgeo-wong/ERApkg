function [ fname,fID ] = eradi_script_create (par,reg)



if ~isnan(par.pre), lvl = sprintf('%dhPa',par.pre);
else,               lvl = 'sfc';
end

fname = [ 'erai-' reg.ID '-' par.ID '-' lvl ];
fID = fopen([ fname '.py' ],'w');

fprintf(1,'Creating download script %s.py ... ',fname);

fprintf(fID,'#!/usr/bin/env python\n');
fprintf(fID,'from ecmwfapi import ECMWFDataServer\n');
fprintf(fID,'server = ECMWFDataServer()\n\n');

end