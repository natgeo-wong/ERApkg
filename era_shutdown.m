function era_shutdown (logf,fol)



fprintf('Log record ended at %s\n',datestr(now)); diary off;
if nargin == 2, movefile(logf,[fol '/log.txt']); end

end