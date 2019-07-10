function erad5_script_pprint (fID,par)



p = par.pre; var = par.era5;
fprintf(fID,'        "variable": "%s",\n',var);
if ~isnan(p), fprintf(fID,'        "pressure_level": "%d",\n',p); end

end