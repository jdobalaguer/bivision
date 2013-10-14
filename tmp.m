%%

clear all;

sdata = load_badgui();

load_numbers;

theta_est = analysis_alltheta(sdata);

perf = [];
for i_subject = 1:nb_subjects
    ii_subject = (sdata.exp_sub == u_subject(i_subject));
    perf(end+1) = nanmean(sdata.resp_cor(ii_subject));
end
u_subject
[theta_est;perf]

figure;
plot(theta_est,perf,'.')
return


%% plot staircase

load matlab;

x_con = 0:0.01:1;
x_acc = 0.5:0.01:1;
f_con = @(p,acc) - log(2*(1 - acc))/p;
f_acc = @(p,con) 1 - .5*exp(-con*p);

p = nlinfit(stair.this_intensity,stair.resp_accuracy,f_accuracy,1);

figure;

subplot(1,2,1);
hold on;
plot(stair.this_intensity,stair.resp_accuracy,'+r');
plot(x_con,f_acc(p,x_con));
xlim([ 0,1]);
ylim([.5,1]);

subplot(1,2,2);
hold on;
plot(stair.resp_accuracy,stair.this_intensity,'+r');
plot(x_acc,f_con(p,x_acc));
xlim([.5,1]);
ylim([ 0,1]);

fprintf('')

return;

%% estimate betas
clear all;
figure;
u_angle = -1:0.2:1;
nb_angles = length(u_angle);
for i_angle = 1:nb_angles
    fprintf('please write %.2f\n',u_angle(i_angle));
    main;
    % subplot beta (actual)
    beta_est = participant.betas;
    subplot(nb_angles,3,3*(i_angle-1) + 1);
    bar(beta_est);
    ylim([-1,1]);
    % subplot beta (mean)
    data.resp_ycat = model.mean.resp_ycat;
    beta_est = analysis_plot_betas(data,'binomial');
    subplot(nb_angles,3,3*(i_angle-1) + 2);
    bar(beta_est);
    ylim([-8,+8]);
    % subplot beta (item)
    data.resp_ycat = model.item.resp_ycat;
    beta_est = analysis_plot_betas(data,'binomial');
    subplot(nb_angles,3,3*(i_angle-1) + 3);
    bar(beta_est);
    ylim([-8,+8]);
    % clean
    clearvars -except i_angle u_angle nb_angles;
end
return;

%% plot mean
clear all;
figure;
for i_group = 1:5
    main;
    % plot mean
    subplot(5,model.item.nb_capacity+1,(i_group-1)*(model.item.nb_capacity+1) + 1);
    imagesc(model.mean.log_Ws);
    % plot items
    for i_capacity = 1:model.item.nb_capacity
        subplot(5,model.item.nb_capacity+1,(i_group-1)*(model.item.nb_capacity+1) + 1 + i_capacity);
        imagesc(squeeze(model.item.log_Ws(:,i_capacity,:)));
    end
    clearvars -except i_group;
end
return;

%% plot mean
figure;
imagesc(model.mean.log_Ws);
return;

%% plot individual
figure;
for i_capacity = 1:model.item.pars_nbcapacity
    subplot(1,model.item.pars_nbcapacity,i_capacity);
    imagesc(squeeze(model.item.log_Ws(:,i_capacity,:)));
end
return;
