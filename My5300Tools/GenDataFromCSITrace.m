function data = GenDataFromCSITrace(csiTraceFile, antennaInd, type)
csiTrace = readfile(csiTraceFile);
P = length(csiTrace);
%     disp(["NPackets:", P])
S = 30;
if type == "rssi"
    data = zeros(1, P);
else
    data = zeros(S, P);
end

for i = 1:P
    csi_entry = csiTrace{i};
    csi = squeeze(get_scaled_csi(csi_entry));
    if csi_entry.Nrx == 1
        csi_ = csi';
    else
        csi_ = csi(antennaInd, :);
    end
    if type == "phase"
        phase = angle(csi_);
        phase = unwrap(phase);
        data(:, i) = PhaseSanitization(phase);
        %             phase = PhaseSanitizationSpotFi(csi);
        %             data(:, i) = phase(antennaInd, :);
    elseif type == "amplitude"
        data(:, i) = abs(csi_(:));
    elseif  type == "phasediff"
        phase = angle(csi);
        phase = unwrap(phase, pi, 2);
        switch antennaInd
            case 1
                data(:, i) = mod(phase(2,:) - phase(1,:), 2*pi);
                %                     data(:, i) = phase(2,:) - phase(1,:);
            case 2
                data(:, i) = mod(phase(3,:) - phase(1,:), 2*pi);
            case 3
                data(:, i) = mod(phase(3,:) - phase(2,:), 2*pi);
        end
    elseif type == "rssi"
        switch antennaInd
            case 1
                data(i) = csi_entry.rssi_a - csi_entry.agc;;
            case 2
                data(i) = csi_entry.rssi_b - csi_entry.agc;;
            case 3
                data(i) = csi_entry.rssi_c - csi_entry.agc;;
        end
    end
end
end