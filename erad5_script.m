function fol = erad5_script (mod,par,drange,reg,root)



pvec = par.pre; mod.pre = par.pre;
for ii = pvec, par.pre = ii;
    
    [ fname,fID ] = erad5_script_create(par,reg);
    
    for jj = drange(1) : drange(2)
        
        erad5_script_header(fID,mod);
        erad5_script_pprint(fID,par);
        erad5_script_region(fID,reg);
        erad5_script_dprint(fID,jj);
        erad5_script_target(fID,fname,jj);
        
    end
    
    erad5_script_close(fID)
    
    fol = era_folder(par,reg,root);
    save('info_par.mat','mod','par'); save('info_reg.mat','reg');
    
    fprintf('Moving files to directories ... ');
    a = pwd; cd(fol.tmp); delete('*.py'); cd(a);
    movefile('*.py',fol.tmp);         copyfile('erad5.gekko',fol.tmp);
    movefile('info_par.mat',fol.var); movefile('info_reg.mat',fol.reg);
    fprintf('done!\n\n');
    
end

end