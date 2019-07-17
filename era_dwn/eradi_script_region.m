function eradi_script_region (fID,reg,mod)



if reg.globe && mod.stp.ID == 1
    fprintf(fID,'    "grid": "0.5/0.5",\n');
elseif reg.globe && mod.stp.ID == 2
    fprintf(fID,'    "grid": "0.75/0.75",\n');
else
    fprintf(fID,'    "area": "%.2f/%.2f/%.2f/%.2f",\n',reg.grid);
    fprintf(fID,'    "grid": "0.25/0.25",\n');
end

end