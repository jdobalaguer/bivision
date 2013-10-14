
%% if exists
if exist('participant','var');
    participant.times = participant.times + 1;
    participant.filename_data  = ['data',filesep,'data_',participant.name,'_',num2str(participant.times),'.mat'];
    participant.filename_error = ['data',filesep,'error_',participant.name,'_',num2str(participant.times),'.mat'];
    return;
end

participant = struct();


%% set participant
% participant info
disp('Participant')
if ~parameters.flag_debug && ~parameters.flag_virtual
    participant.name = input('  Name:     ','s');
    while any(participant.name == ' ')
        fprintf('Please dont use spaces.\n');
        participant.name = input('  Name:     ','s');
    end
    participant.age  = input('  Age:      ','s');
    participant.sex  = input('  Sex:      ','s');
    participant.hand = input('  Hand:     ','s');
else
    participant.name = '';
    participant.age  = '';
    participant.sex  = '';
    participant.hand = '';
end

% experiment info
disp('Experiment')
participant.id      = randi(10000);
participant.times   = 1;
%participant.color   = (rand()>.5);
%participant.origin  = 2*rand() - 1;
if ~parameters.flag_debug
    participant.theta   = str2num(input('  Theta:    ','s'));
    if isempty(participant.theta)
        participant.theta = 1;
    end
else
    participant.theta = 0;
end
if ~parameters.flag_debug && ~parameters.flag_virtual
    participant.filename_data  = ['data',filesep,'data_',participant.name,'_',num2str(participant.times),'.mat'];
    participant.filename_error = ['data',filesep,'error_',participant.name,'_',num2str(participant.times),'.mat'];
    if exist(participant.filename_data,'file')
        error('set_participant: error. data file already exists');
    end
    if exist(participant.filename_error,'file')
        error('set_participant: error. error file already exists');
    end
end

set_beta;
participant.SR          = 1;
if ~parameters.stair_do; parameters.vb_contrast  = str2num(input('  Contrast: ','s')); end
