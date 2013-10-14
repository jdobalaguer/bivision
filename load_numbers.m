
% experiment
u_subject   = unique(sdata.exp_sub);
u_block     = unique(sdata.exp_block);
u_trial     = unique(sdata.exp_trial);

nb_subjects = length(u_subject);
nb_blocks   = length(u_block);
nb_trials   = length(u_trial);