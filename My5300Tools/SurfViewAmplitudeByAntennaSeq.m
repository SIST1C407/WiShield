%% Surf View Amplitude of specigied Rx antennas
%  Output: figure object

function fig = SurfViewAmplitudeByAntennaSeq(filePath, antennaSeq)
    addpath(genpath('..\Basic5300Tools'));
    amplitude = GetAmplitude(filePath);
    Npacket = GetNPackets(filePath);
    fig = figure;
    data = amplitude(antennaSeq, :, :);
    data = squeeze(data);
    fig = surf(data);
    fig.EdgeColor = 'none';
    hold on;
%     hold off;
end