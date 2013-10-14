function [beta_est,beta] = analysis_plot_betas(data,type)
    if ~exist('type','var')
        type = 'binomial';
    end
    
    %% check
    if all(isnan(data.resp_ycat))
        error('analysis_plot_betas: error. all(isnan(data.resp_ycat))');
    end
    
    %% beta
    beta = data.vb_b(:,1);
    
    %% beta estimation
    switch type
        case 'linear'
            % discretize the space, find means
            [m_y,n_x,c_x] = analysis_discretize(data.vb_x,data.resp_ycat,[10,10]);
            % x values
            c_x1 = .5 * (c_x{1}(1:end-1) + c_x{1}(2:end));
            c_x2 = .5 * (c_x{2}(1:end-1) + c_x{2}(2:end));
            x1 = ones(length(c_x1),1) * c_x1 ;
            x2 = c_x2' * ones(1,length(c_x2));
            x = [x1(:),x2(:)];
            % yvalues
            y = m_y(:);
            % beta
            beta_est = pinv(x) * y;
        case 'binomial'
            x = data.vb_x';
            y = (data.resp_ycat'>0);
            beta_est = glmfit(x,y, 'binomial', 'link', 'probit', 'constant', 'off');
        case 'sigmoidal'
            % TODO ##
    end
    
    if nargout; return; end
    
    %% plot betas
    figure;
    bar([beta , beta_est]');
    set(gca,'xticklabel',{'beta','best'});
    
    %% plot ratio
    %{
    figure;
    bar([beta(1)./beta(2) , beta_est(1)./beta_est(2)]');
    set(gca,'xticklabel',{'beta','best'});
    %}
end