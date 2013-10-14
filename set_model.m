
if ~parameters.flag_model; return; end

% struct
if ~exist('model','var')
    model = struct();
end

% set
set_model_random;
set_model_mean;
set_model_item;
set_model_parmean;