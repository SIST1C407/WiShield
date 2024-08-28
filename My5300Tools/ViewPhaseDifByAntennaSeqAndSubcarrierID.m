%% View Phase Difference of specigied Rx antennas
%  Output: figure object

% Input: antennaSeq: [a, b], phase = b - a;
function fig = ViewPhaseDifByAntennaSeqAndSubcarrierID(filePath, antennaSeq, subcarrierID)
    data = GetPhaseDifByAntennaSeqAndSubcarrierID(filePath, antennaSeq, subcarrierID);
    Npacket = GetNPackets(filePath);
    fig = figure;
    scatter(1:Npacket, data, 8, "filled");
%     plot(data);
    hold on;
    set(gca,'YTick',-2*pi:pi/2:2*pi);
    set(gca,'YTicklabel',{'-2pi','-3pi/2','-pi','-pi/2','0','pi/2','pi','3pi/2','2pi'})
    axis([0 Npacket -2*pi 2*pi]);
%     hold off;
end