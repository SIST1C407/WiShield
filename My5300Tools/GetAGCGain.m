%% Get AGC Gain
%  Output: agc - Array Npacket * 1
function agc = GetAGCGain(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Npacket = length(csi_trace);
    agc = zeros(Npacket, 1);
    for i = 1:Npacket
        csi_entry = csi_trace{i};
        agc(i) = csi_entry.agc;
    end
end