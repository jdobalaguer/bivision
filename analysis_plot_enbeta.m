function beta_est = analysis_plot_enbeta(data)
    
    beta_est = analysis_plot_corbeta(data);
    beta_est = [norm(beta_est(1:end-1)), beta_est(end)];
    
    if nargout; return; end
    
    %% plot betas
    figure;
    bar(beta_est');
    
end