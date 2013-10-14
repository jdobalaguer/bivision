function ret = fit_models(sdata,ret)
    
    % load sdata
    if ~exist('sdata','var')
        sdata = load_badgui();
    end
    
    % parameters
    u_prop = 0:0.25:1;%0:0.1:0.9;
    nb_props = length(u_prop);
    
    %% fitting
    if ~exist('ret','var') || isempty(ret)
        % active models
        parameters.flag_model   = 1;
        parameters.flag_virtual = 1;
        parameters.vb_setsize   = size(sdata.vb_x,1);

        % simulation
        models = cell(1,nb_props);
        for i_prop = 1:nb_props
            fprintf('fit_models: u_prop = %.2f\n',u_prop(i_prop));
            % set model
            set_model;
            model.parmean.pars_prop = u_prop(i_prop);
            % run model
            models{i_prop} = main_models(sdata,model);
        end
        
        % save
        ret = struct();
        ret.u_prop   = u_prop;
        ret.nb_props = nb_props;
        ret.models   = models;
    end
    
    %% minimize
    % load numbers
    load_numbers;
    % minimize
    e_prop = nan(nb_subjects,nb_props);
    b_mods = nan(nb_subjects,nb_props,size(sdata.vb_x,1));
    for i_subject = 1:nb_subjects
        % subject index
        ii_subject = (sdata.exp_sub == u_subject(i_subject));
        % data struct
        data            = struct();
        data.vb_x       = sdata.vb_x(:,ii_subject);
        data.vb_b       = sdata.vb_b(:,ii_subject);
        data.resp_ycat  = sdata.resp_ycat(ii_subject);
        % beta estimation
        b_human         = analysis_plot_betas(data);
        %b_human         = b_human / norm(b_human);
        
        for i_prop = 1:nb_props
            % data struct
            data.resp_ycat = ret.models{i_prop}.parmean.resp_ycat(ii_subject);
            % beta estimation
            b_model = analysis_plot_betas(data);
            %b_model = b_model / norm(b_model);
            b_mods(i_subject,i_prop,:) = b_model;
            % error
            e_prop(i_subject,i_prop) = sqrt(mean(power(b_model-b_human,2)));
        end
        
    end
    ret.e_prop = e_prop;
    ret.b_mods = b_mods;
    
    %% plot
    figure;
    tools_dotplot(ret.e_prop);
    
    %% plot
    figure;
    for i_prop = 1:nb_props
        subplot(1,nb_props,i_prop);
        analysis_plot_allpsychophysics(sdata.exp_sub,sdata.vb_y,ret.models{i_prop}.parmean.resp_ycat,8)
    end
    
    %% plot
    figure;
    for i_prop = 1:nb_props
        subplot(1,nb_props,i_prop);
        analysis_plot_allpsychophysics(sdata.exp_sub,mean(sdata.vb_x),ret.models{i_prop}.parmean.resp_ycat,8)
    end
    
    %% plot
    figure;
    for i_subject = 1:nb_subjects
        % figure
        subplot(nb_subjects,1,i_subject);
        % plot
        bar(squeeze(ret.b_mods(i_subject,:,:)));
    end
end