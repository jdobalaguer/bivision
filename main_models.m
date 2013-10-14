function allmodel = main_models(sdata,model)
    
    % load sdata
    if ~exist('sdata','var')
        sdata = load_badgui();
    end
    
    % load numbers
    u_subject   = unique(sdata.exp_sub);
    nb_subjects = length(u_subject);
    
    % active models
    parameters = struct();
    parameters.flag_model   = 1;
    parameters.flag_virtual = 1;
    parameters.vb_setsize   = size(sdata.vb_x,1);
    
    % load model
    if ~exist('model','var')
        set_model;
    end

    % create models
    l = length(sdata.exp_sub);
    allmodel = struct();
    allmodel.random = struct();
    allmodel.random.resp_ycat = nan(1,l);
    allmodel.random.resp_cor  = nan(1,l);
    allmodel.item = struct();
    allmodel.item.resp_ycat = nan(1,l);
    allmodel.item.resp_cor  = nan(1,l);
    allmodel.mean = struct();
    allmodel.mean.resp_ycat = nan(1,l);
    allmodel.mean.resp_cor  = nan(1,l);
    allmodel.parmean = struct();
    allmodel.parmean.resp_ycat = nan(1,l);
    allmodel.parmean.resp_cor  = nan(1,l);
    
    for i_subject = 1:nb_subjects
        %% set model
        set_model;
        
        %% run the task
        % block index
        ii_subject = (sdata.exp_sub == u_subject(i_subject));
        % load numbers
        u_block = unique(sdata.exp_block(ii_subject));
        nb_blocks = length(u_block);
        for i_block = 1:nb_blocks
            % block index
            ii_block = (sdata.exp_block == u_block(i_block));
            % load numbers
            u_trial = unique(sdata.exp_trial(ii_subject & ii_block));
            nb_trials = length(u_trial);
            % blockstruct
            blockstruct = struct();
            blockstruct.vb_x    = sdata.vb_x(:, ii_subject & ii_block);
            blockstruct.vb_y    = sdata.vb_y(   ii_subject & ii_block);
            blockstruct.vb_ycat = sdata.vb_ycat(ii_subject & ii_block);
            
            for i_trial = 1:nb_trials
                % run models
                do_model;
            end
        end

        %% cat model
        % random
        allmodel.random.resp_ycat(ii_subject) = model.random.resp_ycat;
        allmodel.random.resp_cor(ii_subject)  = model.random.resp_cor;
        % item
        allmodel.item.resp_ycat(ii_subject) = model.item.resp_ycat;
        allmodel.item.resp_cor(ii_subject)  = model.item.resp_cor;
        % mean
        allmodel.mean.resp_ycat(ii_subject) = model.mean.resp_ycat;
        allmodel.mean.resp_cor(ii_subject)  = model.mean.resp_cor;
        % parmean
        allmodel.parmean.resp_ycat(ii_subject) = model.parmean.resp_ycat;
        allmodel.parmean.resp_cor(ii_subject)  = model.parmean.resp_cor;

    end
end