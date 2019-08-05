function root = era_root (indir)



if nargin == 1, root.base = [ indir '/reanalysis' ]; 
elseif nargin == 0
    if exist('/Volumes/CliNat-ERA/','dir') == 7
          root.base = '/Volumes/CliNat-ERA/';
    elseif exist('/home/nwong002/reanalysis','dir') == 7
          root.base = '/home/nwong002/reanalysis/';
    else, root.base = '~/Documents/reanalysis/';
    end
else, error('Error in era_root.  Can have at most 1 input variable.');
end

                                  mkfol(root.base);
root.era5 = [ root.base 'era5' ]; mkfol(root.era5);
root.erai = [ root.base 'erai' ]; mkfol(root.erai);
root.plot = [ root.base 'plot' ]; mkfol(root.plot);

end