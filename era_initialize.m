function [ mod,par,trange,reg ] = era_initialize (ini,mID,pID,rtf)


if ~any(nargin == [1 3 4])
    error('Error in era_initialize.  Invalid number of inputs.');
end

if nargin == 1
    mod = era_module(ini); par = era_parameter(mod);
else
    mod = era_module(ini,mID); par = era_parameter(mod,pID);
end

trange = era_time(ini);

if nargin ~=4
    reg = era_region (ini); par = era_pressure(mod,par);
elseif any(rtf)
    reg = era_region (ini,rtf); par = era_pressure(mod,par);
else
    reg = NaN; par.pre = NaN;
end

end