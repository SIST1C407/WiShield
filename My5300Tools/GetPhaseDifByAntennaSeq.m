%% Get Phase Difference of specigied Rx antennas
%  Output: data, 30 * Npackets

% Input: antennaSeq: [a, b], phase = b - a;
function data = GetPhaseDifByAntennaSeq(filePath, antennaSeq)
    addpath(genpath('..\Basic5300Tools'));
    phase = GetPhase(filePath);
    data = phase(antennaSeq(2), :, :) - phase(antennaSeq(1), :, :);
    data = squeeze(data);
%     data = mod(data, 2*pi);
end