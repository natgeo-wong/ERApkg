function dset = era_startup_dataset (ID)



if nargin == 0
    disp('ERApkg supports two different reanalysis datasets:')
    disp('1) ERA5 (latest reanalysis dataset, replaces ERA-Interim)');
    disp('2) ERA-Interim (to be phased out by end 2019)');
    
    disp('Please choose the desired reanalysis dataset:');
    ID = input('  Dataset: '); dset.ID = ID;
    disp(' ');
    
    while ~any(ID == 1:2)
        disp('Invalid reanalysis dataset selected.  Please choose again.');
        ID = input('  Dataset: ');
        disp(' ');
    end
end

dset.ID = ID;
if ID == 1; dset.name = 'ERA5'; else, dset.name = 'ERA-Interim'; end

end