%% Get average packet interval
%  Output: time_interval (second)
function time_interval = GetPacketInterval(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Npacket = length(csi_trace);
    total = csi_trace{Npacket}.timestamp_low - csi_trace{1}.timestamp_low;
    time_interval = total / (Npacket-1); % us
    time_interval = time_interval / 1e6; % s
end