%theta：信号入射角
%tof: s
%bias: m
%d: cm
function data = multipath_data_productor(theta, mptheta, mptof, d)
    n = 50;
%     s = abs(1./(abs(randn(n,1))+1) - 0.5);%源信号各径强度
    s = rand(n,1);
    s(1) = 1;
    d = d/100;%天线距离
    fc = 5320 * 10^6;%中心频率
    sub_freq_delta = (40 * 10^6)/128;%相邻子载波之间的频率差
    SubCarrInd = [-58,-54,-50,-46,-42,-38,-34,-30,-26,-22,-18,-14,-10,-6,-2,2,6,10,14,18,22,26,30,34,38,42,46,50,54,58]; % WiFi subcarrier indices at which CSI is available
    scale = 0.05;%控制噪声
    
    c = 3.0 * 10^8;%光速
    mptof = mptof.*10^(-9);%传播时间(ns->s)
    data = zeros(3, 30);
    bias = [0,0,0];
%     theta_noise = ((randperm(8,1) - 1) * (360/8) + 13);
    theta_noise = rand(1,1) * pi - 2*pi;
    for i = 1:n
%         bias = [0,0,0];
        if i == 1
            mp_theta = theta + theta_noise;
%             tof_ = tof;
        else
            mp_theta = mptheta(i) + theta_noise;
            
        end
        
        data = data + signal_productor(s(i),mp_theta,fc,d,sub_freq_delta,SubCarrInd,bias,scale,c,mptof(i));
    end
end