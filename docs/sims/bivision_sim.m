%
% bivision sim
%
% fixed var(beta), it simulates regression of V to Vi and Vm, and the psychophysical
% curve corresponding.
% distribution of estimations of alpha are also plotted.

%{
    x = [-inf,+inf]
    v = [-inf,+inf]
    b = [0,1]
    r = [0,1]
%}


clear all;
close all;

% parameters
nb_items = 6;
nb_corrs = 100;
nb_samples = 500;
std_betas = 0.1;
std_x      = 1;
std_xnoise = 0.01;
std_rnoise = 0.01;
prop  = 0.2;
curve = 'probit';

% variables
bests = nan(nb_corrs,2);
vars  = nan(nb_corrs,2);
vs = [];
rnoisies = [];

w_n = waitbar(0,'');
for i_corr = 1:nb_corrs
    p_n = i_corr/nb_corrs;
    s_n = sprintf('percentage %2.1f',100*p_n);
    waitbar(p_n,w_n,s_n);
    % input
    x = std_x * randn(nb_samples,nb_items);
    x_noisy = x + std_xnoise * randn(nb_samples,nb_items);
    
    % participant
        % coefficients
    beta_i = (1/nb_items) + std_betas*randn(nb_items,1);
    beta_i = beta_i /sum(beta_i);
    beta_p = (1/nb_items) + 0        *randn(nb_items,1);
        % outputs
    v_i      = x       * beta_i;
    v_p      = x       * beta_p;
    vnoisy_i = x_noisy * beta_i;
    vnoisy_p = x_noisy * beta_p;
        % response
    b = [prop,1-prop]';
    v = [v_i,v_p]*b;
    switch curve
        case 'probit'
            r = glmval(b,[vnoisy_i,vnoisy_p],'probit',[],[],[],[],'off');
            rnoisy =  r + std_rnoise * randn(nb_samples,1);
            rnoisy(rnoisy<0) = 0;
            rnoisy(rnoisy>1) = 1;
        case 'linear'
            r = [vnoisy_i,vnoisy_p]*b;
            rnoisy =  r + std_rnoise * randn(nb_samples,1);
    end
    % regression
    switch curve
        case 'probit'
            bests(i_corr,:) = glmfit([v_i,v_p],rnoisy, 'binomial', 'link', 'probit', 'constant', 'off');
        case 'linear'
            bests(i_corr,:) = pinv([v_i,v_p])*r;
    end            
    vars(i_corr,:) = [var(v_i),var(v_p)];
    
    % store
    vs = [vs,v];
    rnoisies = [rnoisies,rnoisy];
end
close(w_n);

% psychophysic curve
figure;
i = (vs<-2 | vs>+2);
vs(i) = [];
rnoisies(i) = [];
plot(vs,rnoisies,'.');

% histogram of estimated coefficients
figure;
xx = 0:.05:1;
for i = 1:2
    subplot(1,2,i);
    hist(bests(:,i),xx);
    xlim([0,1]);
end