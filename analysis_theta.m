function [theta_est,theta_the] = analysis_theta(data,type)

    if ~exist('type','var')
        type = 'binomial';
    end

    % get betas
    [beta_est,beta_the] = analysis_plot_betas(data,type);
    beta_est = beta_est / norm(beta_est);
    beta_the = beta_the / norm(beta_the);

    % unit vector
    nb_samples = size(data.vb_b,1);
    unit = ones(1,nb_samples);
    unit = unit./norm(unit);

    % theta
    theta_est = acos(sum(beta_est(:) .* unit(:))) *2/pi;
    theta_the = acos(sum(beta_the(:) .* unit(:))) *2/pi;
end