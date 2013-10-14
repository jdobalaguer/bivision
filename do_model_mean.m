
% activation
s = blockstruct.vb_x(:,i_trial);% + 0.2*randn(size(blockstruct.vb_x(:,i_trial)));
x = normpdf(model.mean.pars_fspace, mean(s',2), 0.1);
m_A = x*model.mean.vb_W';

% learning
dW = sign(blockstruct.vb_y(i_trial)) .* x;
model.mean.vb_W = model.mean.vb_W + 0.1.*dW;

% policy
model.mean.resp_ycat(end+1) = sign(m_A);
model.mean.resp_cor(end+1)  = (blockstruct.vb_ycat(i_trial) == model.mean.resp_ycat(end));

% save
model.mean.log_Ws(end+1,:) = model.mean.vb_W;
model.mean.log_mA(end+1,:) = m_A;
model.mean.log_smA(end+1)  = m_A;
