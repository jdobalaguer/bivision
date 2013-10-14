
% value
prop = model.parmean.pars_prop;
m_A = prop*model.mean.log_smA(end) + (1-prop)*model.item.log_smA(end);

% policy
model.parmean.resp_ycat(end+1) = sign(m_A);
model.parmean.resp_cor(end+1)  = (blockstruct.vb_ycat(i_trial) == model.parmean.resp_ycat(end));

% save
model.parmean.log_mA(end+1,:)   = m_A;
model.parmean.log_smA(end+1)    = m_A;
