function PI = era_Pi_ID (ID)



disp('ERApkg supports the creation of PI by various methods:');
disp('1) Askne and Nodius [1997], Tm given by Davis et al. [1985]');
disp('2) Askne and Nodius [1997], Tm given by Bevis et al. [1992], (a,b) given by Bevis et al. [1992]');
disp('3) Askne and Nodius [1997], Tm given by Bevis et al. [1992], (a,b) given by Manandhar et al. [2017]');
disp('4) Askne and Nodius [1997], Tm given by GGOS Atmosphere model (B?ohm & Schuh, 2013)');
disp('5) Askne and Nodius [1997], Tm given by GPT2w model (B?ohm et al., 2015)');
disp('6) Askne and Nodius [1997], Tm given by GTm-III model (Yao et al., 2014)');
disp('7) Manandhar et al. [2017]');

disp('Please choose the method to find PI:');
if nargin < 1, ID = input('  Method: '); disp(' ');
else,          fprintf('  Method: %d\n\n',ID);
end

while ~any(ID == 1:7)
    disp('Invalid PI methodology.  Please try again.');
    ID = input('  Method: '); disp(' ');
end

PI.ID = ID;

if ID == 1,     PI.type = 'AD';
elseif ID == 2, PI.type = 'ABB';
elseif ID == 3, PI.type = 'ABM';
elseif ID == 4, PI.type = 'AGA';
elseif ID == 5, PI.type = 'AG2';
elseif ID == 6, PI.type = 'AGT';
elseif ID == 7, PI.type = 'MN';
end

end