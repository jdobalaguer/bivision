
% initialize
x = nan(model.item.pars_nbcapacity,model.item.pars_neurons);
m_A = nan(model.item.pars_nbcapacity,1);

for i_capacity = 1:model.item.pars_nbcapacity
    % activation
    x(i_capacity,:) = normpdf(model.item.pars_fspace, blockstruct.vb_x(i_capacity,i_trial)', 0.1);
    m_A(i_capacity) = x(i_capacity,:) * model.item.vb_W(i_capacity,:)';
    
    % learning
    dW(i_capacity,:) = sign(blockstruct.vb_y(i_trial)) .* x(i_capacity,:);
    model.item.vb_W(i_capacity,:) = model.item.vb_W(i_capacity,:) + 0.1*dW(i_capacity,:);
end

% policy
model.item.resp_ycat(end+1) = sign(sum(m_A));
model.item.resp_cor(end+1)  = (blockstruct.vb_ycat(i_trial) == model.item.resp_ycat(end));

% save
model.item.log_Ws(end+1,:,:) = model.item.vb_W;
model.item.log_mA(end+1,:)   = m_A;
model.item.log_smA(end+1)    = sum(m_A);
