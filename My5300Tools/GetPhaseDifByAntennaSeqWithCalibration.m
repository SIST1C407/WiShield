%% Get Phase Difference of specigied Rx antennas
%  Output: data, 30 * Npackets

% Input: antennaSeq: [a, b], phase = b - a;
function data = GetPhaseDifByAntennaSeqWithCalibration(filePath, antennaSeq, phase_offset)
    addpath(genpath('..\Basic5300Tools'));
    phase = GetPhaseWithCalibration(filePath, phase_offset);
    data = phase(antennaSeq(2), :, :) - phase(antennaSeq(1), :, :);
    data = squeeze(data);
end