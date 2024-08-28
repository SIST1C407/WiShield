%% View RSS, Amplitude and AGC Gain together of specigied Rx antennas
%  Output: figure object

function [] = ViewRSSAmplitudeGainByAntennaID(filePath, antennaID)
    addpath(genpath('..\Basic5300Tools'));
    amplitude = GetAmplitude(filePath);
    rss = GetRSS(filePath);
    agc = GetAGCGain(filePath);
    Npacket = GetNPackets(filePath);
    Nrx = GetNrx(filePath);
    subcarrierID = 16;
    if Nrx < antennaID
        amplitude = squeeze(amplitude(Nrx, subcarrierID, :));
    else
        amplitude = squeeze(amplitude(antennaID, subcarrierID, :));
    end
    rss = squeeze(rss(antennaID, :));
    
    timestamp = GetTimestamps(filePath);
    timestamp = timestamp./1000000;
%     timestamp = 1:Npacket;
    plot(timestamp,rss);
    hold on;
    plot(timestamp,agc);
    hold on;
    plot(timestamp,amplitude);
    hold on;
%     legend('rss','agc','amplitude', 'Location', 'northoutside');
    axis([0 timestamp(end) -80 80]);
    hold off;
end