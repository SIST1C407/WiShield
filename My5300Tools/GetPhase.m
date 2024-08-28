%% Get phase of all enabled Rx antennas and all subcarriers
%  Output: phase - Array Nrx * Nsubcarrier * Npacket
function phase = GetPhase(filePath)
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
%         d21 =  [-2.7525,-2.6997,-2.7781,-2.7673,-2.6908,-2.6770,-2.6742,-2.7244,-2.7357,-2.6668,-2.7419,-2.7208,-2.6927,-2.7091,-2.6640,-2.6772,-2.6981,-2.6895,-2.7165,-2.7202,-2.6605,-2.7036,-2.6676,-2.6636,-2.6482,-2.6720,-2.6344,-2.6883,-2.6098,-2.6329];
%         csi(2,:) = abs(csi(2,:)).*cos(angle(csi(2,:))-d21)+1i*abs(csi(2,:)).*sin(angle(csi(2,:))-d21);
        
        if csi_entry.Nrx == 1
            phase(1,:,packet) = unwrap(angle(csi(:)), pi, 1);
%             phase(:, :, packet) = angle(csi);
        else
            phase(:, :, packet) = unwrap(angle(csi), pi, 1);
%             phase(:, :, packet) = angle(csi);
        end
    end
end