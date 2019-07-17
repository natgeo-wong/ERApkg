function eradi_script_dprint (fID,yr,par)



fprintf(fID,'    "date": "%d-01-01/to/%d-12-31",\n',yr,yr);

if ~strcmp(par.ID,'cape') && ~strncmp(par.ID,'prcp',4)
    fprintf(fID,'    "time": "00:00:00/06:00:00/12:00:00/18:00:00",\n');
    fprintf(fID,'    "step": "0",\n');
else
    fprintf(fID,'    "time": "00:00:00/12:00:00",\n');
    fprintf(fID,'    "step": "3/6/9/12",\n');
end

end