%
% bivision_space
%
% shows correlation of the mean and
% (maximal) correlation of individual items
% as a function of mean and variance of the beta coefficients

clc;
clear all;

%% parameters
std_x      = 1;
beta_range = [-5,+5];

nb_items = 2;
nb_corrs = 100;
nb_samples = 100;

u_epsilon = (-1/nb_items):(.2/nb_items):(1/nb_items);
u_delta   = 0:(.2/nb_items):(1/nb_items);
nb_epsilons = length(u_epsilon);
nb_deltas = length(u_delta);

%% variables
mean_predicts = nan(nb_epsilons,nb_deltas,nb_corrs);
item_predicts = nan(nb_epsilons,nb_deltas,nb_corrs);

w_n = waitbar(0,'');
i_n = 0;

%% start
for i_epsilon = 1:nb_epsilons
    epsilon = u_epsilon(i_epsilon);
    for i_delta = 1:nb_deltas
        delta = u_delta(i_delta);
        % skip
        if ~epsilon && ~delta
            i_n = i_n + nb_corrs;
        else
            for i_corr = 1:nb_corrs
                %% wait bar
                i_n = i_n + 1;
                p_n = i_n / (nb_epsilons * nb_deltas * nb_corrs);
                s_n = sprintf('percentage %2.1f',100*p_n);
                waitbar(p_n,w_n,s_n);

                %% generate stimulus
                % input
                x = std_x * randn(nb_samples,nb_items);
                % coefficients
                beta = tools_mypseudorandrange(epsilon,delta,nb_items,1,0.005,0.005,beta_range,1)';
                % outputs
                v = x * beta;
                
                %% predictive values
                % mean
                mean_predicts(i_epsilon,i_delta,i_corr) =     abs(corr(mean(x,2),v));
                % individual items
                item_predicts(i_epsilon,i_delta,i_corr) = max(abs(corr(x-epsilon,v)));
            end
        end
    end
end
close(w_n);

%% average
m_meanpredicts = mean(mean_predicts,3);
m_itempredicts = mean(item_predicts,3);
m_meanpredicts(~u_epsilon,~u_delta) = 0;
m_itempredicts(~u_epsilon,~u_delta) = 0.5;

%% plot
close all
figure; surface(u_epsilon,u_delta,m_meanpredicts'); xlabel('mean'); ylabel('var'); set(gca,'clim',[0,1]);
figure; surface(u_epsilon,u_delta,m_itempredicts'); xlabel('mean'); ylabel('var'); set(gca,'clim',[0,1]);


