%% Get RSS of all antennas
%  Output: rss - Array Nantenna * Npacket
function rss = GetRSS(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Nantenna = 3;
    Npacket = length(csi_trace);
    rss = zeros(Nantenna, Npacket);
    for i = 1:Npacket
        csi_entry = csi_trace{i};
        rss(1,i) = csi_entry.rssi_a - csi_entry.agc - 44;
        rss(2,i) = csi_entry.rssi_b - csi_entry.agc - 44;
        rss(3,i) = csi_entry.rssi_c - csi_entry.agc - 44;
    end
end