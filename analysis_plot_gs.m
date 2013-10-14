function [h_x] = analysis_plot_gs(t,x,n)
    
    % remove nans
    i_nan = isnan(x);
    t(i_nan) = [];
    x(i_nan) = [];
    
    % length
    l_t = length(x);
    l_x = length(x);
    
    % check
    if l_t~=l_x; error('analysis_plot_psychophysics: error. x and t must have same length.'); end;
    
    % times
    min_t = min(t);
    max_t = max(t);
    dif_t = (max_t - min_t) / n;
    
    % split
    h_x = nan(1,n);
    for i_n = 1:n
        t1 = min_t + (i_n-1) * dif_t;
        t2 = min_t + (i_n  ) * dif_t;
        ii_t = (t >= t1) & (t <= t2);
        
        h_x(i_n) = mean(x(ii_t));
    end
    
    % plot
    if ~nargout
        plot(1:n,h_x,'.-');
        return;
    end
end