%% Get amplitude of all enabled Rx antennas and all subcarriers
%  Output: rss - Array Nrx * Nsubcarrier * Npacket
function amplitude = GetAmplitude(filePath)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Nrx = csi_trace{1}.Nrx;
    Nsubcarrier = 30;
    Npacket = length(csi_trace);
    amplitude = zeros(Nrx, Nsubcarrier, Npacket);
    for packet = 1:Npacket
        csi_entry = csi_trace{packet};
        csi = get_scaled_csi(csi_entry);
        if csi_entry.Ntx ~= 1
            csi = csi(1,:,:);
        end
        csi = squeeze(csi);
        if csi_entry.Nrx == 1
            amplitude(1,:,packet) = abs(csi(:));
        else
            amplitude(:, :, packet) = abs(csi);
        end
%         for rx = 1:Nrx
%             for subcarrier = 1:Nsubcarrier
%                 amplitude(rx, subcarrier, packet) = 
%             end
%         end
    end
end