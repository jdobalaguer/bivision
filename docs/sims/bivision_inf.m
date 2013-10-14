%
% bivision_inf
%
% shows how much information is given by sets of items x,
% depending on the mean and the variance of the coefficients beta.

clear all;

%% parameters
mean_b     = .5;
std_b      = 0;
std_n      = 0.5;
x_range    = [-5,+5];
beta_range = [-5,+5];

nb_items = 2;
nb_corrs = 50;
nb_samples = 100;

u_epsilon = -(1/nb_items):(.4/nb_items):(1/nb_items);
u_delta   = 0:(.1/nb_items):(.5/nb_items);
nb_epsilons = length(u_epsilon);
nb_deltas = length(u_delta);

%% variables
cors = nan(nb_epsilons,nb_deltas,nb_corrs);
try
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
                    x = tools_mypseudorandrange(epsilon,delta,nb_items,1,0.005,0.005,x_range,nb_samples);
                    % coefficients
                    b = tools_mypseudorandrange(mean_b,std_b,nb_items,1,0.005,0.005,beta_range,1)';
                    % outputs
                    v = x * b;
                    v_cat = sign(v);
                    y = v + std_n * randn(nb_samples,1);
                    % estimation
                    best = pinv(x) * y;
                    vest = x * best;
                    vest_cat = sign(vest);

                    %% performance
                    % correct
                    cor = (v_cat == vest_cat);
                    % store
                    cors(i_epsilon,i_delta,i_corr) = mean(cor);
                end
            end
        end
    end
    close(w_n);

    %% average
    m_cors = mean(cors,3);

    %% plot
    figure; surface(u_epsilon,u_delta,m_cors'); xlabel('mean'); ylabel('var'); zlabel('performance'); zlim([0,1]); set(gca,'clim',[0 1]); colorbar;

catch err
    close(w_n);
    rethrow(err);
end