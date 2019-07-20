function e = era_calc_Td2e (Td)


e0 = 6.1078; L = 2.5*10^6; Rv = 461.51; T0 = 273.16;
e = e0 * exp((L/Rv) * (1/T0 - 1./Td));

end