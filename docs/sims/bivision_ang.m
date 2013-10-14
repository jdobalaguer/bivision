clear all;

% parameters
nb_times = 500;
nb_samples = 4;
err = 0.01;

% variables
u_theta = 0:0.1:1;
nb_thetas = length(u_theta);

% values
betas = nan(nb_times,nb_thetas,nb_samples);

% temporal
w_n = waitbar(0,'');
i_n = 0;

%% for
for i_theta = 1:nb_thetas
    %% unit
    unit = ones(1,nb_samples);
    unit = unit./norm(unit);
    for i_time  = 1:nb_times
        %% wait bar
        i_n = i_n + 1;
        p_n = i_n / (nb_times*nb_thetas);
        s_n = sprintf('percentage %2.1f',100*p_n);
        waitbar(p_n,w_n,s_n);
        %% find a beta
        while 1
            % generate beta
            beta = randn(1,nb_samples);
            beta = beta./norm(beta);
            % if angle is good, get out of here
            if abs((beta*unit') - cos(.5*pi*u_theta(i_theta))) < err
                break
            end
        end
        %% add beta
        % sort
        beta = sort(beta);
        % add
        betas(i_time,i_theta,:) = beta;
        m_betas(i_time,i_theta)   = mean(beta);
        v_betas(i_time,i_theta)   = var( beta);
        s_betas(i_time,i_theta)   = sum( beta);
        p_beta = abs(beta)/sum(abs(beta));
        h_betas(i_time,i_theta)   = -sum(p_beta.*log(p_beta));
    end
end
close(w_n);

%% extra values

%% return
return;

%% plot m_betas/theta
figure;
plot(u_theta,squeeze(mean(betas)),'+-');
% x
xlabel('theta');
xlim([min(u_theta),max(u_theta)]);
% y
ylabel('beta');
ylim([-1,1]);

%% plot m_beta/theta
figure;
plot(u_theta,mean(m_betas),'+-');
% x
xlabel('theta');
xlim([min(u_theta),max(u_theta)]);
% y
ylabel('beta');
ylim([0,1]);

%% plot v_beta/theta
figure;
plot(u_theta,mean(v_betas),'+-');
% x
xlabel('theta');
xlim([min(u_theta),max(u_theta)]);
% y
ylabel('beta');
ylim([0,1]);

%% plot mean h_beta/theta
figure;
plot(u_theta,mean(h_betas),'+-');
% x
xlabel('theta');
xlim([min(u_theta),max(u_theta)]);
% y
ylabel('beta');
ylim([0,1].*get(gca,'ylim'));

%% plot var h_beta/theta
figure;
plot(u_theta,var(h_betas),'+-');
% x
xlabel('theta');
xlim([min(u_theta),max(u_theta)]);
% y
ylabel('beta');
ylim([0,1].*get(gca,'ylim'));

%% plot histogram
figure;
for i_sample = 1:nb_samples
    subplot(1,nb_samples,i_sample);
    hist(betas(:,i_sample));
end

%% plot 3d
figure;
plot3(betas(:,1),betas(:,2),betas(:,3),'r.');