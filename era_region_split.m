function reg = era_region_split (reg)



reg_all = strsplit(reg.ID,'_');

if length(reg_all) == 1,   reg.dwn = reg.ID;
else, reg.ID = reg_all{1}; reg.dwn = reg_all{2}; 
end

end