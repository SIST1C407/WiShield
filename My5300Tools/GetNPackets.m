%% Get packet number in the file
%  Output: Npacket
function Npacket = GetNPackets(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Npacket = length(csi_trace);
end