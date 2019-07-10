function reg = era_region (ini,ID)



rlist = era_region_load(ini);
disp('ERApkg also allows for the selection of regions of interest.  The');
disp('following are available options:');
for ii = 1 : length(rlist), fprintf('%d) %s\n',ii,rlist(ii).desc); end
fprintf('%d) Customized Region\n\n',ii+1);

disp('Please choose the desired region:');
if nargin < 2, ID = input('  Region: '); disp(' ');
else,          fprintf('  Region: %d\n\n',ID);
end

while ~any(ID == 1:ii+1)
    disp('Invalid region option.  Please choose again.');
    ID = input('  Region: ');
    disp(' ');
end

if ID == ii+1
    disp('Custom region options selected.  Please define coordinates.');
    N = input('  Northern Bound: '); W = input('  Western Bound: ');
    S = input('  Southern Bound: '); E = input('  Eastern Bound: ');
    disp(' ');
end

fprintf('Saving region info ... ');
if any(ID == 1:ii)
    reg.ID = rlist(ID).name; reg.grid = rlist(ID).grid;
    reg.name = rlist(ID).desc;
elseif ID == ii+1
    reg.ID = 'custom'; reg.grid = [ N W S E ];
    reg.name = input('  Region Name: '); disp(' ');
end
reg = era_region_vec(reg,ID,ini);
if ID == 1, reg.globe = 1; else, reg.globe = 0; end
fprintf('done!\n');

reg = era_region_split (reg);

if ID ~= 1
    fprintf('ERApkg will %s data within the NWSE bound:\n',ini.actstr);
    fprintf('  [%.2f,%.2f,%.2f,%.2f]\n\n',reg.grid);
else
    fprintf('ERApkg will %s data for the entire globe.\n\n',ini.actstr);
end

end