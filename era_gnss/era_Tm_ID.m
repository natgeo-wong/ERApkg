function Tm = era_Tm_ID (ID)



disp('ERApkg supports the calculation of column-mean temperature by various methods:');
disp('1) Tm given by Davis et al. [1985], Pressure Coordinates, Surface Humidity approximated');
disp('2) Tm given by Davis et al. [1985], Vertical Coordinates, Surface Humidity approximated');
disp('3) Tm given by Davis et al. [1985], Pressure Coordinates, Surface Humidity from Dewpoint');
disp('4) Tm given by Davis et al. [1985], Vertical Coordinates, Surface Humidity from Dewpoint');
disp('5) Tm given by Bevis et al. [1992], (a,b) given by Bevis et al. [1992]');
disp('6) Tm given by Bevis et al. [1992], (a,b) given by Manandhar et al. [2017]');
disp('7) Tm given by GGOS Atmosphere model (Bohm & Schuh, 2013)');
disp('8) Tm given by GPT2w model (Bohm et al., 2015)');
disp('9) Tm given by GTm-III model (Yao et al., 2014)');

disp('Please choose the method to find PI:');
if nargin < 1, ID = input('  Method: '); disp(' ');
else,          fprintf('  Method: %d\n\n',ID);
end

while ~any(ID == 1:9)
    disp('Invalid PI methodology.  Please try again.');
    ID = input('  Method: '); disp(' ');
end

Tm.ID = ID;

if ID == 1,     Tm.type = 'DPA';
elseif ID == 2, Tm.type = 'DVA';
elseif ID == 3, Tm.type = 'DPD';
elseif ID == 4, Tm.type = 'DVD';
elseif ID == 5, Tm.type = 'BB';
elseif ID == 6, Tm.type = 'BM';
elseif ID == 7, Tm.type = 'GA';
elseif ID == 8, Tm.type = 'G2';
elseif ID == 9, Tm.type = 'GT';
end

end