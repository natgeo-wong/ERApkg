function eradi_script_header (fID,par)



fprintf(fID,'server.retrieve({\n');
fprintf(fID,'    "class": "ei",\n');
fprintf(fID,'    "dataset": "interim",\n');
fprintf(fID,'    "stream": "oper",\n');

if ~strcmp(par.ID,'cape') && ~strncmp(par.ID,'prcp',4)
      fprintf(fID,'    "type": "an",\n');
else, fprintf(fID,'    "type": "fc",\n');
end

fprintf(fID,'    "type": "an",\n');
fprintf(fID,'    "expver": "1",\n');

end