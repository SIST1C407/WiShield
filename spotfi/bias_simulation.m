N_seconds = 1;
N_samples_per_s = 100;
N_sample = N_samples_per_s*N_seconds;
N_switch_per_s = N_samples_per_s;
N_sample_per_switch = N_samples_per_s/N_switch_per_s;
N_switches = N_sample/N_sample_per_switch;
N_bias = 2;
aoa = ones(1, N_sample)*999;
bias1 = rand(1, N_bias)*2*pi;
bias2 = rand(1, N_bias)*2*pi;
bias3 = rand(1, N_bias)*2*pi;
bias_ = zeros(N_switches, 3);
for i = 1:N_switches
    bias_(i,:) = [bias1(unidrnd(N_bias)) bias2(unidrnd(N_bias)) bias3(unidrnd(N_bias))];
end

parfor i = 1:N_sample
    distance = 2.5;
%     bias = [bias1(unidrnd(N_bias)) bias2(unidrnd(N_bias)) bias3(unidrnd(N_bias))];
    bias_index = floor((i-1)/N_sample_per_switch)+1;
    bias = bias_(bias_index,:);
    csi = data_productor(30, 100, bias, distance);
    aoaEstimateMatrix = spotfi(csi, distance);
    aoa(i) = aoaEstimateMatrix(1, 2);
end
X = aoa;
Y = 1:N_sample;
sz = 25;
c = linspace(1,10,length(X));
subplot(3, 2, 1)
scatter(X,Y,sz,c,'filled');

total_results = aoa;    
A = categorical(total_results);
degrees = categories(A);
counts = countcats(A);
degrees = str2num(char(degrees));
total_results = [degrees counts'];
total_results = sortrows(total_results, 1, 'descend');
total_results = floor(total_results);
subplot(3, 2, 2)
plot(total_results(2:end-1,1), total_results(2:end-1,2))

count_index = 1;
degree_num = zeros(101, 1);
degrees = floor((-90:180/100:90)*-1);
for i = 1:101
    if total_results(count_index, 1) == degrees(i)
        degree_num(i) = total_results(count_index, 2);
        count_index = count_index + 1;
    end
    if count_index > length(total_results(:,1))
        break;
    end
end
[var(counts) var(degree_num)]

%%
bias_ = zeros(N_switches, 3);
for i = 1:N_switches
    bias_(i,:) = [bias1(unidrnd(N_bias)) bias2(unidrnd(N_bias)) bias3(unidrnd(N_bias))];
end
parfor i = 1:N_sample
    distance = 2.5;
%     bias = [bias1(unidrnd(N_bias)) bias2(unidrnd(N_bias)) bias3(unidrnd(N_bias))];
    bias_index = floor((i-1)/N_sample_per_switch)+1;
    bias = bias_(bias_index,:);
    csi = data_productor(30+i*(5/N_samples_per_s), 100, bias, distance);
    aoaEstimateMatrix = spotfi(csi, distance);
    aoa(i) = aoaEstimateMatrix(1, 2);
end
X = aoa;
Y = 1:N_sample;
sz = 25;
c = linspace(1,10,length(X));
subplot(3, 2, 3)
scatter(X,Y,sz,c,'filled');

total_results = aoa;    
A = categorical(total_results);
degrees = categories(A);
counts = countcats(A);
degrees = str2num(char(degrees));
total_results = [degrees counts'];
total_results = sortrows(total_results, 1, 'descend');
total_results = floor(total_results);
subplot(3, 2, 2)
plot(total_results(2:end-1,1), total_results(2:end-1,2))

count_index = 1;
degree_num = zeros(101, 1);
degrees = floor((-90:180/100:90)*-1);
for i = 1:101
    if total_results(count_index, 1) == degrees(i)
        degree_num(i) = total_results(count_index, 2);
        count_index = count_index + 1;
    end
    if count_index > length(total_results(:,1))
        break;
    end
end
[var(counts) var(degree_num)]
%%
bias_ = zeros(N_switches, 3);
for i = 1:N_switches
    bias_(i,:) = [bias1(unidrnd(N_bias)) bias2(unidrnd(N_bias)) bias3(unidrnd(N_bias))];
end
parfor i = 1:N_sample
    distance = 2.5;
%     if mod(i, N_sample_per_switch) == 1
%         bias = [bias1(unidrnd(N_bias)) bias2(unidrnd(N_bias)) bias3(unidrnd(N_bias))];
%     end
    bias_index = floor((i-1)/N_sample_per_switch)+1;
    bias = bias_(bias_index,:);
    csi = data_productor(30+i*(15/N_samples_per_s), 100, bias, distance);
    aoaEstimateMatrix = spotfi(csi, distance);
    aoa(i) = aoaEstimateMatrix(1, 2);
end
X = aoa;
Y = 1:N_sample;
sz = 25;
c = linspace(1,10,length(X));
subplot(3, 2, 5)
scatter(X,Y,sz,c,'filled');

total_results = aoa;    
A = categorical(total_results);
degrees = categories(A);
counts = countcats(A);
degrees = str2num(char(degrees));
total_results = [degrees counts'];
total_results = sortrows(total_results, 1, 'descend');
total_results = floor(total_results);
subplot(3, 2, 2)
plot(total_results(2:end-1,1), total_results(2:end-1,2))

count_index = 1;
degree_num = zeros(101, 1);
degrees = floor((-90:180/100:90)*-1);
for i = 1:101
    if total_results(count_index, 1) == degrees(i)
        degree_num(i) = total_results(count_index, 2);
        count_index = count_index + 1;
    end
    if count_index > length(total_results(:,1))
        break;
    end
end
[var(counts) var(degree_num)]