function ret = GetNewACSIVarienceIndicator(data, VarienceWindowSize)
HaarWaveletTransformLevel = 5;
data_denoise = DenoiseWithHaarTransform(data, HaarWaveletTransformLevel);
varience_seq = GetVarienceSeq(data_denoise, VarienceWindowSize);
highlyCorrelatedSubcarriers = GetHighlyCorrelatedSubcarriers(varience_seq, 0.5);
data_highCorr = varience_seq(highlyCorrelatedSubcarriers, :);
ret = mean(data_highCorr, 1);
end

function ret = DenoiseWithHaarTransform(data, level)
ret = [];
len = size(data,2);
len = len-(mod(len,2));
for subcarrier = 1:30
    [a, b] = haart(data(subcarrier,1:len));
    denoise_data = ihaart(a, b, level);
    ret = [ret, denoise_data];
end
ret = ret';
end

function ret = GetVarienceSeq(data, windowSize)
ret = zeros(size(data, 1), size(data, 2)-windowSize+1);

for subcarrier = 1:30
    for i = 1:size(ret,2)
        ret(subcarrier, i) = std(data(subcarrier, i:i+windowSize-1));
    end
end
end

function ret = GetHighlyCorrelatedSubcarriers(data, percentage)
NSubcarriers = size(data,1);
corr_arry = zeros(NSubcarriers);
tmp_results = [];
for i = 1:NSubcarriers
    for j = i+1:NSubcarriers
        corr_arry(i,j) = corr(data(i,:)', data(j,:)');
    end
    tmp_results = [tmp_results corr_arry(i,i+1:NSubcarriers)];
end
tmp_results = sort(tmp_results);
threshold = tmp_results(floor(length(tmp_results)*(1-percentage)));
tmp_results = [];
for i = 1:NSubcarriers
    for j = i+1:NSubcarriers
        if corr_arry(i,j) >= threshold
            tmp_results = [tmp_results i j];
        end
    end
end
ret = sort(unique(tmp_results));
end