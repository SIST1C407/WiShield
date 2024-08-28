%% View RSS of Rx antennas
%  Output: figure object

function fig = ViewRSSofAllAntennas(filePath)
    addpath(genpath('..\Basic5300Tools'));
    rss = GetRSS(filePath);
    Npacket = GetNPackets(filePath);
    fig = figure;
    for i = 1:3
        plot(1:Npacket, rss(i,:));
        hold on;
    end
    legend('1','2','3', 'Location', 'northoutside', 'NumColumns', 3);
    hold off;
end