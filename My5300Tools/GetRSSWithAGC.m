%% Get RSS of all antennas with AGC gain
%  Output: rss - Array Nantenna * Npacket
function rss = GetRSSWithAGC(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Nantenna = 3;
    Npacket = length(csi_trace);
    rss = zeros(Nantenna, Npacket);
    for i = 1:Npacket
        csi_entry = csi_trace{i};
        rss(1,i) = csi_entry.rssi_a;
        rss(2,i) = csi_entry.rssi_b;
        rss(3,i) = csi_entry.rssi_c;
    end
end