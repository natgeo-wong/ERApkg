function PI = era_PI_ID (ID)



disp('ERApkg supports the creation of PI by three different methods:');
disp('1) Askne and Nodius [1997], Tm given by Davis et al. [1985]');
disp('2) Askne and Nodius [1997], Tm given by Bevis et al. [1992]');
disp('3) Manandhar et al. [2017]');

disp('Please choose the method to find PI:');
if nargin < 1, ID = input('  Method: '); disp(' ');
else,          fprintf('  Method: %d\n\n',ID);
end

while ~any(ID == 1:3)
    disp('Invalid PI methodology.  Please try again.');
    ID = input('  Method: '); disp(' ');
end

PI.ID = ID;

if ID == 1,     PI.type = 'AND';
elseif ID == 2, PI.type = 'ANB';
elseif ID == 3, PI.type = 'MEA';
end

end