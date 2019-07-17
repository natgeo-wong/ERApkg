function eradi_script_pprint (fID,par)



p = par.pre; var = par.erai;
fprintf(fID,'    "param": "%s",\n',var);
if isnan(p)
    fprintf(fID,'    "levtype": "sfc",\n');
else
    fprintf(fID,'    "levtype": "pl",\n');
    fprintf(fID,'    "levelist": "%d",\n',p);
end

end