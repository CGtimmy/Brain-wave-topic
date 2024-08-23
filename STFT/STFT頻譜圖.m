data = load('/Users/hoyi/Downloads/0708何翊/20240715131051_test_bleEXGdata.mat');
data = data.data;
data = double(data);
data = data';

% 提取CZ和FZ data(通道一 通道二）
cz_signal = data(:, 1); 
fz_signal = data(:, 2);
fs = 250;
window = hamming(250);
noverlap = 125; 
nfft = 256; 
total_time = length(cz_signal) / fs ;
tCZ = (0:length(cz_signal)-1) / fs;
tFZ = (0:length(fz_signal)-1) / fs;
fprintf('整段時間: %.f 秒\n', total_time);
fprintf('data長度: %.f\n', size(cz_signal));

% 計算CZ信號的STFT
[cz_s, cz_f, cz_t, cz_p] = spectrogram(cz_signal, window, noverlap, nfft, fs);
% 計算FZ信號的STFT
[fz_s, fz_f, fz_t, fz_p] = spectrogram(fz_signal, window, noverlap, nfft, fs);

% CZ矩陣大小
[m, n] = size(cz_s);
fprintf('cz_s 矩陣大小 %d x %d\n', m, n);

% 顯示前10row和前10column
%disp(cz_p(1:10, 1:10));

start_time = 0;
end_time = 430;

% 繪製CZ頻譜圖
figure;
subplot(2,1,1);
surf(cz_t, cz_f, 10*log10(abs(cz_p)), 'EdgeColor', 'none');
axis tight;
ylim([0 60]);
xlim([start_time end_time])  %秒數區段
xticks(start_time:10:end_time) %每幾秒顯示一個刻度
view(0, 90);
colorbar;
title('CZ Spectrogram');
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
caxis([-10 20]);
colormap(jet);

% 繪製FZ頻譜圖
subplot(2,1,2);
surf(fz_t, fz_f, 10*log10(abs(fz_p)), 'EdgeColor', 'none');
axis tight;
ylim([0 60]);
xlim([start_time end_time])  %秒數區段
xticks(start_time:10:end_time) %每幾秒顯示一個刻度
view(0, 90);
colorbar;
title('FZ Spectrogram');
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
caxis([-10 20]);
colormap(jet);
