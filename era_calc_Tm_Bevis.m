function Tm = era_calc_Tm_Bevis (Ts,a,b)



if nargin == 1, a = 70.2; b = 0.72; end; Tm = a + b * Ts;

end