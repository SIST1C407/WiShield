%% Get phase of all enabled Rx antennas and all subcarriers
%  Output: phase - Array Nrx * Nsubcarrier * Npacket
function phase = GetPhaseWithCalibration(filePath, phase_offset)
    addpath(genpath('..\Basic5300Tools'));
    csi_trace = readfile(filePath);
    Nrx = csi_trace{1}.Nrx;
    Nsubcarrier = 30;
    Npacket = length(csi_trace);
    phase = zeros(Nrx, Nsubcarrier, Npacket);
    for packet = 1:Npacket
        csi_entry = csi_trace{packet};
        csi = get_scaled_csi(csi_entry);
                
        if csi_entry.Ntx ~= 1
            csi = csi(1,:,:);
        end
        csi = squeeze(csi);
        d21 =  phase_offset;
        csi(2,:) = abs(csi(2,:)).*cos(angle(csi(2,:))+d21)+1i*abs(csi(2,:)).*sin(angle(csi(2,:))+d21);
        
        if csi_entry.Nrx == 1
            phase(1,:,packet) = unwrap(angle(csi(:)), pi, 1);
%             phase(:, :, packet) = angle(csi);
        else
            phase(:, :, packet) = unwrap(angle(csi), pi, 1);
%             phase(:, :, packet) = angle(csi);
        end
    end
end