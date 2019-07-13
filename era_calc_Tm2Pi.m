function PI = era_calc_Tm2Pi (Tm)



K3 = 3.739*10^3; K2 = 0.221; Rv = 461.5181;
PI = 10^6 ./ ((K3 ./ Tm + K2) * Rv) / 1000;

end