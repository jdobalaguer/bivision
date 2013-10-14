
if ~isfield(model,'parmean')
    % struct
    model.parmean = struct();

    % parameters
    model.parmean.pars_prop = 0.5;
end

% log
model.parmean.log_mA       = nan(0, 1);
model.parmean.log_smA      = nan(0, 1);
model.parmean.resp_ycat    = nan(0, 1);
model.parmean.resp_cor     = nan(0, 1);
