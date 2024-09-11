%theta：信号入射角
%tof: s
%bias: m
%d: cm
function data = data_productor(theta, tof, bias, d)
    s = 1;%源信号
    d = d/100;%天线距离
    fc = 5310 * 10^6;%中心频率
    sub_freq_delta = (40 * 10^6)/128;%相邻子载波之间的频率差
    SubCarrInd = [-58,-54,-50,-46,-42,-38,-34,-30,-26,-22,-18,-14,-10,-6,-2,2,6,10,14,18,22,26,30,34,38,42,46,50,54,58]; % WiFi subcarrier indices at which CSI is available
    bias = bias/3e8;%干扰(s)
    scale = 0.01;%控制噪声
    c = 3.0 * 10^8;%光速
%     tof = tof*10^(-9);%传播时间(ns->s)
    data = signal_productor(s,theta,fc,d,sub_freq_delta,SubCarrInd,bias,scale,c,tof);
end