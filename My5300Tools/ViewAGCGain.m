%% View AGC Gain
%  Output: figure object

function fig = ViewAGCGain(filePath)
    addpath(genpath('..\Basic5300Tools'));
    agc = GetAGCGain(filePath);
    fig = figure;
    plot(agc);
    hold on;
%     hold off;
end