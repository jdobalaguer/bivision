function [yvalues,nvalues,xvalues] = analysis_discretize(x,y,n)
    % lengths
    l1_x = size(x,1);
    l2_x = size(x,2);
    l_y = length(y);
    l_n = length(n);
    
    % check
    if l1_x ~= l_n; error('x and n have not matching..'); end
    if l2_x ~= l_y; error('x and y not matching..'); end
    if l_n ~= 2;    error('not bi-dimensional..'); end
    
    % discretize
    xvalues = cell(1,l_n);
    for i1_x = 1:l1_x
        % x values (sorted)
        this_x = sort(x(i1_x,:),'ascend');
        l_thisx = length(this_x);
        % slots
        i_thisx = ceil(1 : ((l_thisx-1)/(n(i1_x))) : l_thisx);
        xvalues{i1_x} = this_x(i_thisx);
    end
    
    % calculate mean
    yvalues = nan(n);
    nvalues = nan(n);
    for i1_n = 1:n(1)
        for i2_n = 1:n(2)
            ii_x1_upper = x(1,:) <= xvalues{1}(i1_n+1);
            ii_x1_lower = x(1,:) >= xvalues{1}(i1_n+0);
            ii_x2_upper = x(2,:) <= xvalues{2}(i2_n+1);
            ii_x2_lower = x(2,:) >= xvalues{2}(i2_n+0);
            
            ii_x = (ii_x1_upper & ...
                    ii_x1_lower & ...
                    ii_x2_upper & ...
                    ii_x2_lower);
            
            if any(ii_x)
                yvalues(i1_n,i2_n) = mean(y(ii_x));
            end
            nvalues(i1_n,i2_n) = sum(ii_x);
        end
    end
    
    if ~nargout
        plot_x1 = .5 * ( xvalues{1}(1:end-1) + xvalues{1}(2:end) );
        plot_x2 = .5 * ( xvalues{2}(1:end-1) + xvalues{2}(2:end) );
        
        close all;
        figure;
        surface( ...
            plot_x1,...
            plot_x2,...
            yvalues ...
            );
    end
end