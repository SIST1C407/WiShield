%% Get Total RSS
%  Output: rss - Array Npacket * 1
function rss = GetTotalRSS(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Npacket = length(csi_trace);
    rss = zeros(Npacket, 1);
    for i = 1:Npacket
        csi_entry = csi_trace{i};
        rss(i) = get_total_rss(csi_entry);
    end
end