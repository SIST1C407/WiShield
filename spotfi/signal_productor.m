%s：源信号
%theta：角度
%fc：中心频率
%d：天线之间的距离
%s1：输出信号
function data = signal_productor(s,theta,fc,d,sub_freq_delta,SubCarrInd,bias,scale,c,tof)
%     theta = (theta/180)*pi;
    data = zeros(3,30);
    for ii = 1:30
        sub_freq = 2*pi* (fc + SubCarrInd(ii)*sub_freq_delta);
        data(1,ii) = s*exp(-1i*sub_freq*(tof+bias(1))+scale*(rand(1,1)+rand(1,1)*1i));
        data(2,ii) = s*exp(-1i*sub_freq*(sin(theta)*d/c+tof+bias(2))+scale*(rand(1,1)+rand(1,1)*1i));
        data(3,ii) = s*exp(-1i*sub_freq*(sin(theta)*2*d/c+tof+bias(3))+scale*(rand(1,1)+rand(1,1)*1i));
    end
end