
% policy
model.random.resp_ycat(end+1) = sign(rand);
model.random.resp_cor(end+1)  = (blockstruct.vb_ycat(i_trial) == model.random.resp_ycat(end));

