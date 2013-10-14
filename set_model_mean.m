
if ~isfield(model,'mean')
    % struct
    model.mean = struct();

    % parameters
    model.mean.pars_neurons = 1e2;
    model.mean.pars_fspace = linspace(-1,1,model.mean.pars_neurons);

    % variables
    model.mean.vb_W = randn(1,length(model.mean.pars_fspace),1).*0.001;
end

% log
model.mean.log_Ws       = nan(0,model.mean.pars_neurons);
model.mean.log_mA       = nan(0,1);
model.mean.log_smA      = nan(0,1);
model.mean.resp_ycat    = nan(0,1);
model.mean.resp_cor     = nan(0,1);
