function parlist = era_parameter_load (mod)



parlist = textread('era_parameter.txt','%s',...
    'commentstyle','shell','delimiter',',');
type = mod.type; parlist = reshape(parlist,7,[])'; ID = parlist(:,1);

tf = double(strcmp(ID,type)); tf = tf==0; parlist(tf,:) = [];

end