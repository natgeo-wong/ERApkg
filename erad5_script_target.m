function erad5_script_target (fID,fname,yr)



fprintf(fID,'        "format": "netcdf"\n');
fprintf(fID,'    },\n');
fprintf(fID,'    "%s-%d.nc")\n\n',fname,yr);

end