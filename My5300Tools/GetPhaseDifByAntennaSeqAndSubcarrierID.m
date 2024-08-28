%% Get Phase Difference of specigied Rx antennas and subcarrier ID
%  Output: figure object

% Input: antennaSeq: [a, b], phase = b - a;
function data = GetPhaseDifByAntennaSeqAndSubcarrierID(filePath, antennaSeq, subcarrierID)
    addpath(genpath('..\Basic5300Tools'));
    phase = GetPhase(filePath);
    data = phase(antennaSeq(2), subcarrierID, :) - phase(antennaSeq(1), subcarrierID, :);
    data = squeeze(data);
%     data = mod(data, 2*pi);
end