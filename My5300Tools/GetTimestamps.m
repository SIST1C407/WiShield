%% Get Timestamps
%  Output: timestamp - Array Npacket * 1 (us)
function timestamp = GetTimestamps(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Npacket = length(csi_trace);
    timestamp = zeros(Npacket, 1);
    for i = 1:Npacket
        csi_entry = csi_trace{i};
        if i == 1
            time_init = csi_entry.timestamp_low;
        end
        timestamp(i) = csi_entry.timestamp_low;
    end
    timestamp = timestamp - time_init;
end