function reg = era_region_vec (reg,ID,ini)



grid = reg.grid; N = grid(1); W = grid(2); S = grid(3); E = grid(4);

if     ID == 1 && ini.ID == 1, step = 0.5;
elseif ID == 1 && ini.ID == 2, step = 0.75;
else,                          step = 0.25;
end

lon = W : step  : E; nlon = numel(lon); reg.lon  = lon;
lat = N : -step : S; nlat = numel(lat); reg.lat  = lat;
                                        reg.size = [ nlon nlat ];

end