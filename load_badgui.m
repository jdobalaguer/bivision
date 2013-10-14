% LOAD EVERYTHING INTO A SINGLE STRUCT
function sdata = load_badgui()
    datafolder = 'data';

    % subjects' file names
    lsdata = regexp(ls(datafolder),'\s','split');
    i = 1;
    while i<=length(lsdata)
        if isempty(lsdata{i})
            lsdata(i) = [];
        else
            i = i+1;
        end
    end

    % subjects
    nb_subjects = length(lsdata);
    for i_subjects = 1:nb_subjects
        % load
        load([datafolder,filesep,lsdata{i_subjects}]);
        % concatenate
        if i_subjects==1
            sdata = data;
        else
            sdata = tools_catstruct(sdata,data);
        end
    end
end
