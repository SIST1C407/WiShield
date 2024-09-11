% clear;
locations = -27.5:2.5:12.5; % antenna distance cm
% batches = ['1' '2' '3' '4' '5' '6' '7' '8' '9'];
% batches = ["1" "2" "3" "4" "5" "6"];
% batches = ['5' '6' '7' '8' '9'];
% batches = [""];
% batches = ["1" "10" "100" "1000"];
batches = 1:10;

Ntx = 1;
Npacket = 360;
Nresults = 8;
Nbatches = length(batches);
theta = zeros(Nbatches, Ntx, Npacket, 4, Nresults);
dis = zeros(Nbatches, Ntx, Npacket, 4, Nresults);
packet_nums = zeros(Nbatches, 1);

bias = ones(2, Nbatches).*rand(2, Nbatches)*0.05;
bias(:,1) = [0; 0];
bias(:,2) = [2e-04; 0.0036];

distance = 2.5;
test_num = "2";
location_num = "9";
folder = "0617";
houzhui = "_"
dis_path = sprintf('data/%s/test%s_%s_dis_%s%s.mat', folder, test_num, location_num, num2str(distance), houzhui);
theta_path = sprintf('data/%s/test%s_%s_theta_%s%s.mat', folder, test_num, location_num, num2str(distance), houzhui);
% dis_path = 'data/0617/tmp_dis.mat';
% theta_path = 'data/0617/tmp_theta.mat';

for i = 1:1%:length(locations)
    for j = 1:1:length(batches)
        j
        bias1 = bias(1,j);
        bias2 = bias(2,j);
        
        location = locations(i);
%         location = 0;
        batch = batches(j);
%         antenna = 'C';
%         distance = 2.7;
%         antenna = 1;
%         file_name = sprintf("%s_%s_1", num2str(antenna), num2str(location))
%         file_name = sprintf("%s_%s", num2str(location), num2str(antenna))
%         file_path = sprintf("data/3/%s.dat", file_name);
%         file_path = sprintf("data/0527/tmp%s_40", antenna)
%         file_path = sprintf("data/0526/test_%s_no2_1", antenna)
%         file_path = "data/far/c4/c123_4_3";
        file_path = "data/0617/tmp";
%         file_path = "data/0609/test1_1_1";
%         file_path = sprintf("data/%s/test%s_%s_%s", folder, test_num, location_num, batches(j))
%         file_path = sprintf("data/%s/test%s_%s", folder, test_num, location_num)
        
        csi_trace = readfile(file_path);
        packet_nums(j) = length(csi_trace);
        % % 5G
        fc = 5.310e9; % center frequency
        M = 3;    % number of rx antennas
        fs = 40e6; % channel bandwidth
        c = 3e8;  % speed of light
        d = distance*0.01;  % distance between adjacent antennas in the linear antenna array
%         d = 2.5e-2;
        % dTx = 2.6e-2; 
        SubCarrInd = [-58,-54,-50,-46,-42,-38,-34,-30,-26,-22,-18,-14,-10,-6,-2,2,6,10,14,18,22,26,30,34,38,42,46,50,54,58]; % WiFi subcarrier indices at which CSI is available
%         SubCarrInd = 1:30;
%         SubCarrInd = [-28,-26,-24,-22,-20,-18,-16,-14,-12,-10,-8,-6,-4,-2,-1,1,3,5,7,9,11,13,15,17,19,21,23,25,27,28];
        N = length(SubCarrInd); % number of subcarriers
        % subCarrSize = 128;  % total number fo
        fgap = fs/128;
%         fgap = 312.5e3; % frequency gap in Hz between successive subcarriers in WiFi
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
        paramRange.GridPts = [101 101 1]; % number of grid points in the format [number of grid points for ToF (Time of flight), number of grid points for angle of arrival (AoA), 1]
        paramRange.delayRange = [-100 100]*1e-9; % lowest and highest values to consider for ToF grid. 1~0.3m
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
%%

%         for index = 1:1
        for index=1:1:length(csi_trace)
%         parfor index=1:1:360%length(csi_trace)
            % num_packets = floor(length(csi_trace)/1);
            % sample_csi_traceTmp = csi_sampling(csi_trace, num_packets, 1, length(csi_trace));
%             csi_entry = csi_trace{index};
%             csi_tmp = get_scaled_csi(csi_entry);
            
            tmp_theta = zeros(Ntx, 4, Nresults);
            tmp_dis = zeros(Ntx, 4, Nresults);
            for tx_index = 1:1:Ntx
                %   Only consider measurements for transmitting on one antenna
%                 csi = csi_tmp(tx_index, :, :);
                % Remove the single element dimension
%                 csi_ = squeeze(csi);
                
              %% calibration 1
%                 d21 = d21_in;
%                 d31 = d31_in;
%                 csi = csi_;
%                 csi(2,:) = abs(csi_(2,:)).*cos(angle(csi_(2,:))-d21)+1i*abs(csi_(2,:)).*sin(angle(csi_(2,:))-d21);
%                 csi(3,:) = abs(csi_(3,:)).*cos(angle(csi_(3,:))-d31)+1i*abs(csi_(3,:)).*sin(angle(csi_(3,:))-d31);
                
                csi = data_productor(30*2*pi/360, 100e-9/3, [0 0 0], 2.5);
                csi = csi';
                plot(angle(csi(:,2))-angle(csi(:,1)))
                set(gca,'YTick',-2*pi:pi/2:2*pi);
                set(gca,'YTicklabel',{'-2pi','-3pi/2','-pi','-pi/2','0','pi/2','pi','3pi/2','2pi'})
                axis([0 30 -2*pi 2*pi]);
                hold on;
    
                sample_csi_trace = csi(:);

                % sample CSI trace is a 90x1 vector where first 30 elements correspond to subcarriers for first rx antenna, second 30 correspond to CSI from next 30 subcarriers and so on.
                % replace sample_csi_trace with CSI from Intel 5300 converted to 90x1 vector
%                 sample_csi_traceTmp = load('sample_csi_trace');
%                 sample_csi_trace = sample_csi_traceTmp.sample_csi_trace;

                % ToF sanitization code (Algorithm 1 in SpotFi paper)
                csi_plot = reshape(sample_csi_trace, N, M);
                [PhsSlope, PhsCons] = removePhsSlope(csi_plot,M,SubCarrInd,N);
                ToMult = exp(1i* (-PhsSlope*repmat(SubCarrInd(:),1,M) - PhsCons*ones(N,M) ));
                csi_plot = csi_plot.*ToMult;
%                 plot(angle(csi_plot(:,1)));
%                 hold on;
%                 plot(angle(csi_plot(:,3)));
%                 hold off;
%                 plot(angle(csi_plot(:,2))-angle(csi_plot(:,1)));
%                 hold off;
                relChannel_noSlope = reshape(csi_plot, N, M, T);
                sample_csi_trace_sanitized = relChannel_noSlope(:);
                

                % MUSIC algorithm for estimating angle of arrival
                % aoaEstimateMatrix is (nComps x 5) matrix where nComps is the number of paths in the environment. First column is ToF in ns and second column is AoA in degrees as defined in SpotFi paper
                aoaEstimateMatrix = backscatterEstimationMusic(sample_csi_trace_sanitized, M, N, c, fc,...
                                    T, fgap, SubCarrInd, d, paramRange, maxRapIters, useNoise, do_second_iter, ones(8))
                tofEstimate = aoaEstimateMatrix(:,1); % ToF in nanoseconds
                aoaEstomate = aoaEstimateMatrix(:,2); % AoA in degrees
                
                tmp = zeros(Nresults-length(aoaEstomate), 1);
                aoaEstomate = [aoaEstomate; tmp];
                tmp_theta(tx_index, 1, :) = aoaEstomate;
                tofEstimate = [tofEstimate; tmp];
                tmp_dis(tx_index, 1, :) = tofEstimate * 0.3;
                
                theta(j,:,index, :, :) = tmp_theta;
                dis(j,:,index, :, :) = tmp_dis;
            end
            fprintf("%d\n",index);
        end
    end
end
% save(dis_path, 'dis');
% save(theta_path, 'theta');