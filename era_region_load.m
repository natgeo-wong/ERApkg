function reg = era_region_load(stp)



reglist = textread('era_region.txt','%s',...
    'commentstyle','shell','delimiter',',');
reglist = reshape(reglist,7,[])';

if stp.act == 1
    ID = reglist(:,1); tf = double(strcmp(ID,'dwn'));
    tf = tf==0; reglist(tf,:) = [];
end
nreg = size(reglist,1);

for ii = 1 : nreg
    
    reg(ii).name = reglist{ii,2};
    N = str2double(reglist{ii,3}); W = str2double(reglist{ii,4});
    S = str2double(reglist{ii,5}); E = str2double(reglist{ii,6});
    reg(ii).grid = [ N W S E ];
    reg(ii).desc = reglist{ii,end};
    
end

end