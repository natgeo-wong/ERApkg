function era_parameter_disp (name,parlist)



fprintf('The following variables are offered in the %s module:\n',name);
for ii = 1 : size(parlist,1), fprintf('%d) %s\n',ii,parlist{ii,6}); end
disp(' ');

end