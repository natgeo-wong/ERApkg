function mapksd = eraa_ksdensity (mapts)



dim = size(mapts); nt = dim(end); np = numel(mapts) / nt; dim(end) = [];
mapts = reshape(mapts,np,nt); mapksd = zeros(np,100,2);

for ii = 1 : np, mapii = mapts(ii,:);
    [ mapksd(ii,:,1),mapksd(ii,:,2) ] = ksdensity(mapii);
end

mapksd = reshape(mapksd,[dim 100 2]);

end