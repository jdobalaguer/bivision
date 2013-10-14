function beta = tools_setbeta(nb_samples,theta,err)
    if ~exist('theta','var')
        theta = 0.5;
    end
    if ~exist('err','var')
        err = 0.001;
    end
    
    %% unit
    unit = ones(1,nb_samples);
    unit = unit./norm(unit);
    %% find a beta
    while 1
        % generate beta
        beta = randn(1,nb_samples);
        beta = beta./norm(beta);
        % if angle is good, get out of here
        if abs((beta*unit') - cos(.5*pi*theta)) < err
            break
        end
    end
end
    