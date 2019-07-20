function PI = era_calc_Pi_MN (mod,yr,mlat,alt)

%                             GPSMet_PI_M2017
%     Defines the PI constant, formula based on Manandhar et al., 2017
%                          Nathanael Wong Zhixin
%
% This function calculates the values of PI, which is the conversion factor
% between ZWD and PWV.  This PI model is based upon the results of 
% Manandhar et al., 2017, which gives a simplified model for the conversion
% of ZWD to PWV based upon the known position of the GPS station and time
% of year, as well as altitude, when available.
%
% This function supports array inputs.
%
% POSSIBLE FORMATS OF CALL:
% 1) PI = era_calc_PI_MN (era-module,year,lat)
% 2) PI = era_calc_PI_MN (era-module,year,lat,alt)
%
% INPUT:
% -- mod : ERA module and dataset
% -- yr  : year
% -- lat : latitude of GPS station
% -- alt : altitude of GPS station (optional)
%
% OUTPUT:
% -- PI  : array containing PI conversion factor
%
% NOTES:
% 1) alt is an optional variable
%
% VERSIONS:
% 1.0 -- Created on 090118 by Nathanael Wong Zhixin

%%%%%%%%%%%%%%%%%%% CHECK INPUT AND NUMBER OF ARGUMENTS %%%%%%%%%%%%%%%%%%%

if nargin > 4 || nargin < 3
    error('Error in era_calc_PI_MN.  Wrong number of input arguments');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%% LATITUDE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%

dset = mod.stp.ID; if dset == 1, n = 24; elseif dset == 2, n = 4; end
dim = size(mlat); mlat = mlat(:);
sphi = sign(mlat); ndy = yeardays(yr); dy = ((1:ndy*n)-1)/n;
hfac = sphi; hfac(hfac == 1) = 1.48; hfac(hfac == -1) = 1.25;

%%%%%%%%%%%%%%%%%%%%%% PI CONVERSION FACTOR FORMULA %%%%%%%%%%%%%%%%%%%%%%%

PI = ( -1 .* sphi * 1.7*10^(-5) .* abs(mlat).^hfac - 0.0001 ) ...
     * cos ((dy-28)*2*pi/365.25) ...
     + 0.165 - 1.7*10^(-5) .* abs(mlat).^1.65;

% if altitude is a significant factor, add in the altitude term
% this term is negligible if the altitude of GPS station is less than 1km
if nargin == 4, alt = alt(:); PI = PI - 2.38 * 10^-6 * alt; end

PI = reshape(PI,[dim ndy*n]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end