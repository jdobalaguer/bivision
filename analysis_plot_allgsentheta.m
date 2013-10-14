function beta_est = analysis_plot_allgsentheta(sdata,nb_timeslots)
    
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
    
    % cues z-scores
    m_vbx = mean(sdata.vb_x,   2) * ones(1,length(sdata.vb_x));
    s_vbx = std( sdata.vb_x,[],2) * ones(1,length(sdata.vb_x));
    vb_x  = (sdata.vb_x - m_vbx) ./ s_vbx;
    
    beta_est    = nan(nb_subjects,nb_timeslots,3);
    for i_subject = 1:nb_subjects
        % subject index
        ii_subject = (sdata.exp_sub == u_subject(i_subject));
        % times
        min_t = min(sdata.resp_gs(ii_subject));
        max_t = max(sdata.resp_gs(ii_subject));
        dif_t = (max_t - min_t) / nb_timeslots;
        
        for i_timeslot = 1:nb_timeslots
            % time index
            t1 = min_t + (i_timeslot-1) * dif_t;
            t2 = min_t + (i_timeslot  ) * dif_t;
            ii_timeslot = (sdata.resp_gs >= t1) & (sdata.resp_gs <= t2);
            
            % data struct
            data            = struct();
            data.vb_x       =       vb_x(:,     ii_subject & ii_timeslot);
            data.vb_b       = sdata.vb_b(:,     ii_subject & ii_timeslot);
            data.vb_e1      =       vb_e1(      ii_subject & ii_timeslot);
            data.vb_e2      =       vb_e2(      ii_subject & ii_timeslot);
            data.vb_ycat    = sdata.vb_ycat(    ii_subject & ii_timeslot);
            data.resp_ycat  = sdata.resp_ycat(  ii_subject & ii_timeslot);
            data.resp_cor   = sdata.resp_cor(   ii_subject & ii_timeslot);
            % get corbetas
            beta_est(i_subject,i_timeslot,1)   = analysis_theta(data);
            beta_est(i_subject,i_timeslot,2:3) = analysis_plot_enbeta(data);
        end
    end
    
    if nargout; return; end
    
    %% plot
    figure;
    i_plot = 0;
    for i_subject = 1:nb_subjects
        for i_timeslot = 1:nb_timeslots
            % figure
            i_plot = i_plot + 1;
            subplot(nb_subjects,nb_timeslots,i_plot);
            
            % plot
            bar(squeeze(beta_est(i_subject,i_timeslot,:)));
            xlim([0.5,3.5]);
            ylim([0,10]);
            
            % legend
            set(gca,'xticklabel',{'theta','cue','gabor'});
            if i_timeslot==1; ylabel(['subject ',num2str(i_subject)]); end
        end
    end
    
end