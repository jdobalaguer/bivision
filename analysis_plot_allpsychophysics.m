function [h_x] = analysis_plot_allpsychophysics(s,x,y,n)
    
    % remove nans
    i_nan = isnan(x);
    s(i_nan) = [];
    x(i_nan) = [];
    y(i_nan) = [];
        
    % numbers
    u_s = unique(s);
    nb_ss = length(u_s);
    
    yy = [];
    for i_s = 1:nb_ss
        % find trials
        ii_s = (s == u_s(i_s));
        this_x = x(ii_s);
        this_y = y(ii_s);
        % get values
        yy = [yy ; analysis_plot_psychophysics(this_x,this_y,n)];
    end
    
    % plot
    if ~nargout
        tools_dotplot(yy);
        return;
    end
end