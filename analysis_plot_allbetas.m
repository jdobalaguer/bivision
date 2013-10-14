function [beta_est,beta] = analysis_plot_allbetas(sdata,type)
    
    % load sdata
    if ~exist('sdata','var')
        sdata = load_badgui();
    end
    
    % load numbers
    load_numbers;
    
    % type
    if ~exist('type','var')
        type = 'binomial';
    end
    
    %% get betas
    beta_est    = nan(nb_subjects,size(sdata.vb_x,1));
    beta        = nan(nb_subjects,size(sdata.vb_x,1));
    for i_subject = 1:nb_subjects
        % subject index
        ii_subject = (sdata.exp_sub == u_subject(i_subject));
        % data struct
        data            = struct();
        data.vb_x       = sdata.vb_x(:,ii_subject);
        data.vb_b       = sdata.vb_b(:,ii_subject);
        data.resp_ycat  = sdata.resp_ycat(ii_subject);
        % beta estimation
        [beta_est(i_subject,:),beta(i_subject,:)] = analysis_plot_betas(data,type);
    end
    
    %% plot
    figure;
    i_plot = 0;
    for i_subject = 1:nb_subjects
        % figure
        i_plot = i_plot + 1;
        subplot(nb_subjects,2,i_plot);
        % plot
        bar(beta_est(i_subject,:));
        ylim([-.5,2])
        % figure
        i_plot = i_plot + 1;
        subplot(nb_subjects,2,i_plot);
        % plot
        bar(beta(i_subject,:));
        ylim([-.5,2])
        
    end
end