function [h_x] = analysis_plot_gs(s,t,x,n)
    
    % remove nans
    i_nan = isnan(x);
    s(i_nan) = [];
    t(i_nan) = [];
    x(i_nan) = [];
    
    % numbers
    u_s = unique(s);
    nb_ss = length(u_s);
    
    y = [];
    for i_s = 1:nb_ss
        % find trials
        ii_s = (s == u_s(i_s));
        this_t = t(ii_s);
        this_x = x(ii_s);
        % get values
        y = [y ; analysis_plot_gs(this_t,this_x,n)];
    end
    
    % plot
    if ~nargout
        tools_dotplot(y);
        return;
    end
end