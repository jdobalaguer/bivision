function beta_est = analysis_plot_allenbeta(sdata)
    
    % load sdata
    if ~exist('sdata','var')
        sdata = load_badgui();
    end
    
    % load numbers
    load_numbers;
    
    % energy z-scores
    m_vbe = mean(sdata.vb_e1-sdata.vb_e2,   2);
    s_vbe = std( sdata.vb_e1-sdata.vb_e2,[],2);
    vb_e1 = (sdata.vb_e1-sdata.vb_e2 - m_vbe) ./ s_vbe;
    vb_e2 = zeros(size(vb_e1));
    vb_e1 = sdata.vb_e1;
    vb_e2 = sdata.vb_e2;
    
    % cues z-scores
    m_vbx = mean(sdata.vb_x,   2) * ones(1,length(sdata.vb_x));
    s_vbx = std( sdata.vb_x,[],2) * ones(1,length(sdata.vb_x));
    vb_x  = (sdata.vb_x - m_vbx) ./ s_vbx;
    %vb_x  = sdata.vb_x;
    
    beta_est    = nan(nb_subjects,2);
    for i_subject = 1:nb_subjects
        % subject index
        ii_subject = (sdata.exp_sub == u_subject(i_subject));
        % data struct
        data            = struct();
        data.vb_x       =       vb_x(:,     ii_subject);
        data.vb_e1      =       vb_e1(      ii_subject);
        data.vb_e2      =       vb_e2(      ii_subject);
        data.vb_ycat    = sdata.vb_ycat(    ii_subject);
        data.resp_cor   = sdata.resp_cor(   ii_subject);
        % get corbetas
        beta_est(i_subject,:) = analysis_plot_enbeta(data);
    end
    if nargout; return; end
    
    %% plot
    figure;
    i_plot = 0;
    for i_subject = 1:nb_subjects
        % figure
        i_plot = i_plot + 1;
        subplot(nb_subjects,1,i_plot);
        % plot
        bar(beta_est(i_subject,:));
        ylim([0,20])
    end
    
end