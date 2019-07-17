function erad5_script_dprint (fID,yr)



fprintf(fID,'        "year": "%d",\n',yr);
fprintf(fID,'        "month":[\n');
fprintf(fID,'            "01","02","03","04","05","06",\n');
fprintf(fID,'            "07","08","09","10","11","12"\n');
fprintf(fID,'        ],\n');
fprintf(fID,'        "day":[\n');
fprintf(fID,'            "01","02","03","04","05","06",\n');
fprintf(fID,'            "07","08","09","10","11","12",\n');
fprintf(fID,'            "13","14","15","16","17","18",\n');
fprintf(fID,'            "19","20","21","22","23","24",\n');
fprintf(fID,'            "25","26","27","28","29","30",\n');
fprintf(fID,'            "31"\n');
fprintf(fID,'        ],\n');
fprintf(fID,'        "time":[\n');
fprintf(fID,'            "00:00","01:00","02:00","03:00","04:00",\n');
fprintf(fID,'            "05:00","06:00","07:00","08:00","09:00",\n');
fprintf(fID,'            "10:00","11:00","12:00","13:00","14:00",\n');
fprintf(fID,'            "15:00","16:00","17:00","18:00","19:00",\n');
fprintf(fID,'            "20:00","21:00","22:00","23:00"\n');
fprintf(fID,'        ],\n');

end