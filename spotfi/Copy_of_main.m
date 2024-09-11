% clear;

locations = -27.5:2.5:12.5; % antenna distance cm
antennas = ['A' 'B' 'C'];

for i = 1:1%:length(locations)
    for j = 1:1%:length(antennas)
        location = locations(i);
        location = 0;
        antenna = antennas(j);
        antenna = 'C';
        distance = 2.5;
%         antenna = 1;
        file_name = sprintf("%s_%s_1", num2str(antenna), num2str(location))
%         file_name = sprintf("%s_%s", num2str(location), num2str(antenna))
%         file_path = sprintf("data/3/%s.dat", file_name);
%         file_path = sprintf("data/%s_orig.dat", file_name);
        file_path = "data/far/c4/c123_4_2";
%         file_path = "data/tmp";
        
        csi_trace = readfile(file_path);

        % % 5G
        fc = 5.320e9; % center frequency
        M = 3;    % number of rx antennas
        fs = 40e6; % channel bandwidth
        c = 3e8;  % speed of light
        d = distance*0.01;  % distance between adjacent antennas in the linear antenna array
%         d = 2.5e-2;
        % dTx = 2.6e-2; 
        SubCarrInd = [-58,-54,-50,-46,-42,-38,-34,-30,-26,-22,-18,-14,-10,-6,-2,2,6,10,14,18,22,26,30,34,38,42,46,50,54,58]; % WiFi subcarrier indices at which CSI is available
        N = length(SubCarrInd); % number of subcarriers
        % subCarrSize = 128;  % total number fo
        fgap = 312.5e3; % frequency gap in Hz between successive subcarriers in WiFi
        lambda = c/fc;  % wavelength
        T = 1; % number of transmitter antennas

        % % 2.4G
        % fc = 2.437e9; % center frequency
        % M = 3;    % number of rx antennas
        % fs = 20e6; % channel bandwidth
        % c = 3e8;  % speed of light
        % d = 6e-2;  % distance between adjacent antennas in the linear antenna array
        % % dTx = 2.6e-2; 
        % SubCarrInd = [-28,-26,-24,-22,-20,-18,-16,-14,-12,-10,-8,-6,-4,-2,-1,1,3,5,7,9,11,13,15,17,19,21,23,25,27,28]; % WiFi subcarrier indices at which CSI is available
        % N = length(SubCarrInd); % number of subcarriers
        % % subCarrSize = 128;  % total number fo
        % fgap = 312.5e3; % frequency gap in Hz between successive subcarriers in WiFi
        % lambda = c/fc;  % wavelength
        % T = 1; % number of transmitter antennas

        % MUSIC algorithm requires estimating MUSIC spectrum in a grid. paramRange captures parameters for this grid
        % For the following example, MUSIC spectrum is caluclated for 101 ToF (Time of flight) values spaced equally between -25 ns and 25 ns. MUSIC spectrum is calculated for for 101 AoA (Angle of Arrival) values between -90 and 90 degrees.
        paramRange = struct;
        paramRange.GridPts = [201 201 1]; % number of grid points in the format [number of grid points for ToF (Time of flight), number of grid points for angle of arrival (AoA), 1]
        paramRange.delayRange = [-50 50]*1e-9; % lowest and highest values to consider for ToF grid. 1~0.3m
        paramRange.angleRange = 90*[-1 1]; % lowest and values to consider for AoA grid.
        do_second_iter = 0;
        % paramRange.seconditerGridPts = [1 51 21 21];
        paramRange.K = floor(M/2)+1; % parameter related to smoothing.  
        paramRange.L = floor(N/2); % parameter related to smoothing.  
        paramRange.T = 1;
        paramRange.deltaRange = [0 0]; 

        maxRapIters = Inf;
        useNoise = 0;
        paramRange.generateAtot = 2;

        csi_entry = csi_trace{1};
        csi = get_scaled_csi(csi_entry);
        Ntx = size(csi,1);
        theta = zeros(Ntx, length(csi_trace), 2);
        dis = zeros(Ntx, length(csi_trace), 2);
        location_x = zeros(Ntx, length(csi_trace), 2);
        location_y = zeros(Ntx, length(csi_trace), 2);
        
        parfor index = 1:12
%         for index=1:1%:length(csi_trace)
%         parfor index=1:1:length(csi_trace)
            % num_packets = floor(length(csi_trace)/1);
            % sample_csi_traceTmp = csi_sampling(csi_trace, num_packets, 1, length(csi_trace));
            csi_entry = csi_trace{index};
            csi_ = get_scaled_csi(csi_entry);
            
            tmp_theta = zeros(Ntx, 2);
            tmp_dis = zeros(Ntx, 2);
            for tx_index = 1:1:Ntx
                %   Only consider measurements for transmitting on one antenna
                csi = csi_(tx_index, :, :);
                % Remove the single element dimension
                csi = squeeze(csi);
                
                % calibration
                d21 = d21_in;
                d31 = d31_in - pi;
                csi(2,:) = abs(csi(2,:)).*cos(angle(csi(2,:))-d21)+1i*abs(csi(2,:)).*sin(angle(csi(2,:))-d21);
                csi(3,:) = abs(csi(3,:)).*cos(angle(csi(3,:))-d31)+1i*abs(csi(3,:)).*sin(angle(csi(3,:))-d31);
                csi = csi';
                
                
    %             data = data_productor(30);
    %             csi = data';
    
                sample_csi_trace = csi(:);

                % sample CSI trace is a 90x1 vector where first 30 elements correspond to subcarriers for first rx antenna, second 30 correspond to CSI from next 30 subcarriers and so on.
                % replace sample_csi_trace with CSI from Intel 5300 converted to 90x1 vector
                % sample_csi_traceTmp = load('sample_csi_trace');
                % sample_csi_trace = sample_csi_traceTmp.sample_csi_trace;

                % ToF sanitization code (Algorithm 1 in SpotFi paper)
                csi_plot = reshape(sample_csi_trace, N, M);
                [PhsSlope, PhsCons] = removePhsSlope(csi_plot,M,SubCarrInd,N);
                ToMult = exp(1i* (-PhsSlope*repmat(SubCarrInd(:),1,M) - PhsCons*ones(N,M) ));
                csi_plot = csi_plot.*ToMult;
                relChannel_noSlope = reshape(csi_plot, N, M, T);
                sample_csi_trace_sanitized = relChannel_noSlope(:);
%                 sample_csi_trace_sanitized = sample_csi_trace;
                

                % MUSIC algorithm for estimating angle of arrival
                % aoaEstimateMatrix is (nComps x 5) matrix where nComps is the number of paths in the environment. First column is ToF in ns and second column is AoA in degrees as defined in SpotFi paper
                aoaEstimateMatrix = backscatterEstimationMusic(sample_csi_trace_sanitized, M, N, c, fc,...
                                    T, fgap, SubCarrInd, d, paramRange, maxRapIters, useNoise, do_second_iter, ones(2))
                tofEstimate = aoaEstimateMatrix(:,1); % ToF in nanoseconds
                aoaEstomate = aoaEstimateMatrix(:,2); % AoA in degrees
                tmp_theta(tx_index, :) = aoaEstomate;
                tmp_dis(tx_index, :) = tofEstimate * 0.3;
            end
            theta(:,index,:) = tmp_theta;
            dis(:,index,:) = tmp_dis;
            fprintf("%d\n",index);
        end
%         X = 1:1:length(theta);
%         figure(11);
% %         scatter(X, theta)
%         axis([0 length(results) -90 90])
% %         saveas(gcf,strcat('D:\Matlab\spotfimusicaoaestimation\data\figures\', file_name, '.jpg'));
%         figure(12);
%         theta_choose = 1;
%         dis_choose = 2;
%         for tx_index = 1:Ntx
%             scatter(dis(tx_index,:,dis_choose).*sind(theta(tx_index,:,theta_choose)), dis(tx_index,:,dis_choose).*cosd(theta(tx_index,:,theta_choose)));
%             hold on;
%             axis([-2 2 -2 2])
% %             w = waitforbuttonpress;
%         end
%         hold off;
%         figure(13);
%         choose = 2;
%         for tx_index = 1:Ntx
%             scatter(dis(tx_index,:,dis_choose).*sind(theta(tx_index,:,theta_choose)), dis(tx_index,:,dis_choose).*cosd(theta(tx_index,:,theta_choose)));
%             hold on;
%             axis([-2 2 -2 2])
% %             w = waitforbuttonpress;
%         end
%         hold off;
    end
end