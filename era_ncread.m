function data = era_ncread(ncname,par,varargin)



try    data = ncread(ncname,par.ID,varargin{:});
catch, data = ncread(ncname,par.IDnc,varargin{:});
end

end