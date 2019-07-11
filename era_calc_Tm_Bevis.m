function Tm = era_calc_Tm_Bevis (Ts,ID,reg,a,b)



if nargin == 1, a = 70.2; b = 0.72; end

if nargin == 3
    if ID == 2, a = 70.2; b = 0.72;
    elseif ID == 3
        a = zeros(1,reg.nlat); b = a; lat = abs(reg.lat);
        a(lat<=23)        = 129.13; b(lat<=23)        = 0.52;
        a(lat>23&lat<=36) = 106.36; b(lat>23&lat<=36) = 0.60;
        a(lat>36)         = 67.12;  b(lat>36)         = 0.73;
    else, error('Incorrect/invalid method selected for calculating Tm.');
    end
end

Tm = a + b .* Ts;

end