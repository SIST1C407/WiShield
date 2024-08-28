%% View RSS of specigied Rx antennas
%  Output: figure object

function fig = ViewRSSByAntennaID(filePath, antennaID)
    addpath(genpath('..\Basic5300Tools'));
    rss = GetRSS(filePath);
    Npacket = GetNPackets(filePath);
    fig = figure;
    plot(1:Npacket, rss(antennaID,:));
    legend(int2str(antennaID), 'Location', 'best');
    hold off;
end