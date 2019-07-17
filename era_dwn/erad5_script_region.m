function erad5_script_region (fID,reg)



if ~reg.globe
    fprintf(fID,'        "area": [%.2f,%.2f,%.2f,%.2f],\n',reg.grid);
else
    fprintf(fID,'        "grid": [2.5,2.5],\n');
end

end