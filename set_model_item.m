
if ~isfield(model,'item')
    % struct
    model.item = struct();

    % parameters
    model.item.pars_neurons = 1e2;
    model.item.pars_fspace = linspace(-1,1,model.item.pars_neurons);
    model.item.pars_nbcapacity = parameters.vb_setsize;
end

% variables
model.item.vb_W = randn(model.item.pars_nbcapacity,length(model.item.pars_fspace),1).*0.001;

% log
model.item.log_Ws       = nan(0, model.item.pars_nbcapacity, model.item.pars_neurons);
model.item.log_mA       = nan(0, model.item.pars_nbcapacity);
model.item.log_smA      = nan(0, 1);
model.item.resp_ycat    = nan(0, 1);
model.item.resp_cor     = nan(0, 1);
