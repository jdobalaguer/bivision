function beta_est = analysis_plot_corbeta(data)
    
    %% check
    if all(isnan(data.resp_cor))
        error('analysis_plot_betas: error. all(isnan(data.resp_cor))');
    end
    
    %% beta estimation
    tmp_ss = size(data.vb_x,1);
    vb_sx = (ones(tmp_ss,1)*data.vb_ycat) .* (data.vb_x);
    vb_e  = data.vb_e1-data.vb_e2;
    x = [vb_sx;vb_e]';
    y = data.resp_cor';
    tmp_b = glmfit(x,y, 'binomial', 'link', 'probit', 'constant', 'off');
    beta_est = tmp_b(1:end);
    
    if nargout; return; end
    
    %% plot betas
    figure;
    bar(beta_est');
    
end