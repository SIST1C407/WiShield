%theta���ź������
%tof: s
%bias: m
%d: cm
function data = data_productor(theta, tof, bias, d)
    s = 1;%Դ�ź�
    d = d/100;%���߾���
    fc = 5310 * 10^6;%����Ƶ��
    sub_freq_delta = (40 * 10^6)/128;%�������ز�֮���Ƶ�ʲ�
    SubCarrInd = [-58,-54,-50,-46,-42,-38,-34,-30,-26,-22,-18,-14,-10,-6,-2,2,6,10,14,18,22,26,30,34,38,42,46,50,54,58]; % WiFi subcarrier indices at which CSI is available
    bias = bias/3e8;%����(s)
    scale = 0.01;%��������
    c = 3.0 * 10^8;%����
%     tof = tof*10^(-9);%����ʱ��(ns->s)
    data = signal_productor(s,theta,fc,d,sub_freq_delta,SubCarrInd,bias,scale,c,tof);
end