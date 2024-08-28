%% Get Number of Rx Antennas
%  Output: Nrx - Int
function Nrx = GetNrx(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    csi_entry = csi_trace{1};
    Nrx = csi_entry.Nrx;
end