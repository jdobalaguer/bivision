
if ~parameters.flag_model; return; end

% run models
do_model_random;
do_model_mean;
do_model_item;
do_model_parmean;