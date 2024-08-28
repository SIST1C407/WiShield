%% Get amplitude of all enabled Rx antennas and all subcarriers
%  Output: rss - Array Nrx * Nsubcarrier * Npacket
function SNR = GetAverageSNR(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Npacket = length(csi_trace);
    SNR = zeros(7,4);
    for packet = 1:Npacket
        csi_entry = csi_trace{packet};
        csi = get_scaled_csi(csi_entry);
        SNR = SNR + db(get_eff_SNRs(csi), 'pow');
    end
    SNR = SNR./Npacket;
end