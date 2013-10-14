function sdatas = analysis_split_energy(sdata,nb_energyslots)
    
    % structs
    sdatas = cell(1,nb_energyslots);
    u_field = fieldnames(sdata);
    nb_fields = length(u_field);
    
    % split
    nb_trials = length(sdata.vb_e1);
    [~,ii_sort] = sort(sdata.vb_e1-sdata.vb_e2);
    
    min_es = 1;
    max_es = nb_trials;
    dif_es = (max_es - min_es) / nb_energyslots;

    for i_energyslot = 1:nb_energyslots
        % time index
        es1 = min_es + (i_energyslot-1) * dif_es;
        es2 = min_es + (i_energyslot  ) * dif_es;
        ii_trials = ii_sort(es1:es2);
        
        sdatas{i_energyslot} = struct();
        for i_field = 1:nb_fields
            sdatas{i_energyslot}.(u_field{i_field}) = sdata.(u_field{i_field})(ii_trials);
        end    
    end
    
end