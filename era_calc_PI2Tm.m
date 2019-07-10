function Tm = era_calc_PI2Tm (PI)



K3 = 3.739*10^3; K2 = 0.221; Rv = 461.5181;
Tm = K3 ./ (10^3 ./ (Rv * PI) - K2);

end