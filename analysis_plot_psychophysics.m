function [h_y,h_x] = analysis_plot_psychophysics(x,y,n)
    
    % remove nans
    i_nan = isnan(x) | isnan(y);
    x(i_nan) = [];
    y(i_nan) = [];
    
    % length
    l_x = length(x);
    l_y = length(y);
    if l_x~=l_y; error('analysis_plot_psychophysics: error. x and y must have same length.'); end;
    d = floor(l_x / n);
    % sort
    [s_x,i_sort] = sort(x);
    s_y = y(i_sort);
    % split
    h_x = nan(1,n);
    h_y = nan(1,n);
    for i_h = 1:n
        ii_h = ((i_h-1)*d+1) : (i_h*d);
        h_x(i_h) = mean(s_x(ii_h));
        h_y(i_h) = mean(s_y(ii_h));
    end
    % plot
    if ~nargout
        plot(h_x,h_y,'.-');
        return;
    end
end