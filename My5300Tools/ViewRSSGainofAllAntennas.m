%% View RSS and AGC Gain together of all Rx antennas
%  Output: figure object

function [] = ViewRSSGainofAllAntennas(filePath)
    addpath(genpath('..\Basic5300Tools'));
    
    rss = GetRSS(filePath);
    agc = GetAGCGain(filePath);
%     fig = figure;    
    
    for i = 1:3
        plot(rss(i,:));
        hold on;
    end
    plot(agc);
    hold on;
    legend('rss1','rss2','rss3', 'agc', 'Location', 'best');

    hold off;
end