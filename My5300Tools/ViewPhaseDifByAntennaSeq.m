%% View Phase Difference of specigied Rx antennas
%  Output: figure object

% Input: antennaSeq: [a, b], phase = b - a;
function fig = ViewPhaseDifByAntennaSeq(filePath, antennaSeq)
    addpath(genpath('..\Basic5300Tools'));
    phase = GetPhase(filePath);
    Npacket = GetNPackets(filePath);
    fig = figure;
    data = phase(antennaSeq(2), :, :) - phase(antennaSeq(1), :, :);
    data = squeeze(data);
    
%     data = mod(data, 2*pi);
    for i = 1:Npacket
%         scatter3(ones(1, Npacket)*i, 1:Npacket, data(i, :), 1);
        plot(data(:,i));
        hold on;
    end
    
%     set(gca,'YTick',0:pi/2:2*pi);
%     set(gca,'YTicklabel',{'0','pi/2','pi','3pi/2','2pi'})
%     axis([0 30 0 2*pi]);
    
    set(gca,'YTick',-2*pi:pi/2:2*pi);
    set(gca,'YTicklabel',{'-2pi','-3pi/2','-pi','-pi/2','0','pi/2','pi','3pi/2','2pi'})
    axis([0 30 -2*pi 2*pi]);
%     hold off;
end