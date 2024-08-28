%% View Amplitude of specigied Rx antennas
%  Output: figure object

function fig = ViewAmplitudeByAntennaSeq(filePath, antennaSeq)
    addpath(genpath('..\Basic5300Tools'));
    amplitude = GetAmplitude(filePath);
    Npacket = GetNPackets(filePath);
    fig = figure;
    data = amplitude(antennaSeq, :, :);
    data = squeeze(data);
    for i = 1:30
        scatter3(ones(1, Npacket)*i, 1:Npacket, data(i, :), 1);
        hold on;
    end
%     hold off;
end