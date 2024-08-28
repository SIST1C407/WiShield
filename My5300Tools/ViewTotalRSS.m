%% View Total RSS
%  Output: figure object

function fig = ViewTotalRSS(filePath)
    addpath(genpath('..\Basic5300Tools'));
    rss = GetTotalRSS(filePath);
    fig = figure;
    plot(rss);
    hold on;
%     hold off;
end