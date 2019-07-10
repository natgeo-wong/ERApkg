function eradi_script_target (fID,fname,yr)



fprintf(fID,'    "format": "netcdf",\n');
fprintf(fID,'    "target": "%s-%d.nc",\n',fname,yr);
fprintf(fID,'})\n\n');

end