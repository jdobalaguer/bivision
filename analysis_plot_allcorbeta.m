function betas = analysis_plot_allcorbeta(sdata)
    
    % load sdata
    if ~exist('sdata','var')
        sdata = load_badgui();
    end
    
    % load numbers
    load_numbers;
    
    beta_est    = nan(nb_subjects,size(sdata.vb_x,1)+1);
    for i_subject = 1:nb_subjects
        % subject index
        ii_subject = (sdata.exp_sub == u_subject(i_subject));
        % data struct
        data            = struct();
        data.vb_x       = sdata.vb_x(:,     ii_subject);
        data.vb_e1      = sdata.vb_e1(      ii_subject);
        data.vb_e2      = sdata.vb_e2(      ii_subject);
        data.vb_ycat    = sdata.vb_ycat(    ii_subject);
        data.resp_cor   = sdata.resp_cor(   ii_subject);
        % get corbetas
        beta_est(i_subject,:) = analysis_plot_corbeta(data);
    end
    
    %% plot
    figure;
    i_plot = 0;
    for i_subject = 1:nb_subjects
        % figure
        i_plot = i_plot + 1;
        subplot(nb_subjects,1,i_plot);
        % plot
        bar(beta_est(i_subject,:));
        ylim([-.5,2])
    end
    
end