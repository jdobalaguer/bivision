function [thetas_est,thetas_the] = analysis_alltheta(sdata,type)
    
    % load sdata
    if ~exist('sdata','var')
        sdata = load_badgui();
    end
    
    % load numbers
    load_numbers;
    
    % set type
    if ~exist('type','var')
        type = 'binomial';
    end
    
    thetas_est = nan(1,nb_subjects);
    thetas_the = nan(1,nb_subjects);
    for i_subject = 1:nb_subjects
        % subject index
        ii_subject = (sdata.exp_sub == u_subject(i_subject));
        % data struct
        data                = struct();
        data.vb_x           = sdata.vb_x(:,ii_subject);
        data.vb_b           = sdata.vb_b(:,ii_subject);
        data.resp_ycat      = sdata.resp_ycat(ii_subject);
        % theta estimation
        [thetas_est(i_subject),thetas_the(i_subject)] = analysis_theta(data,type);
    end
    
end