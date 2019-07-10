function len = era_module_disp (actID)



if actID == 1,     len = 4;
    disp('There are four types of modules that ERApkg can download');
elseif actID == 2, len = 6;
    disp('There are six types of modules that ERApkg can analyse');
end


disp('1) Dry Surface Modules    (e.g. Surface Winds)');
disp('2) Dry Pressure Modules   (e.g. Winds at Pressure Height)');
disp('3) Moist Surface Modules  (e.g. Rainfall, Total Column Water)');
disp('4) Moist Pressure Modules (e.g. Humidity at Pressure Height)');

if actID == 2
    disp('5) Calc Surface Modules   (e.g. PI)');
    disp('6) Calc Pressure Modules  (e.g. Eddy Kinetic Energy, Psi)');
end


end