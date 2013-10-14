
if ~parameters.flag_alertmail; return; end
if parameters.flag_virtual; return; end

%% Error
if exist('err','var')
    tools_alertmail(['bivision: ',participant.name,': error!']);
end


%% End of task
if end_of_task
    tools_alertmail(['bivision: ',participant.name,': finished']);
    return;
end

%% Blocks
if ~exist('i_alertblock','var')
    i_alertblock = 1;
end
if parameters.task_by_blocks
    while   length(parameters.alert_blocks) <= i_alertblock && ...
            parameters.alert_blocks(i_alertblock) <= gm
        tools_alertmail(['bivision: ',participant.name,': ',num2str(parameters.alert_blocks(i_alertblock)),' blocks']);
        i_alertblock = i_alertblock+1;
    end
end

%% Minutes
if ~exist('i_alertmin','var')
    i_alertmin = 1;
end
if parameters.task_by_min
    gs = GetSecs - ptb.time_start(end);
    gm = gs/60;
    while   length(parameters.alert_min) <= i_alertmin && ...
            parameters.alert_min(i_alertmin) <= gm
        tools_alertmail(['bivision: ',participant.name,': ',num2str(parameters.alert_min(i_alertmin)),' mins']);
        i_alertmin = i_alertmin+1;
    end
end

