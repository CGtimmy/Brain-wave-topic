% 教學範例：生成樣本波型並計算其STFT
% 1. 取樣頻率 Fs = 250
% 2. 產生一個樣本波型
%    - 0到2秒: 5Hz 振幅3 + 8Hz 振幅5 + 17Hz 振幅2 的複合波型
%    - 3到5秒: 8Hz 振幅3 + 17Hz 振幅7 的複合波型
% 3. 繪製STFT圖，不使用dB，使用振幅單位

clear all;
close all;

% 參數設置
Fs = 250;           % 取樣頻率 (Hz)
T = 1/Fs;           % 取樣周期 (秒)
t_total = 5;        % 總時間 (秒)
t = 0:T:t_total-T;  % 時間向量

% 波型生成
x1 = 3*sin(2*pi*5*t(t <= 2)) + 5*sin(2*pi*8*t(t <= 2)) + 2*sin(2*pi*17*t(t <= 2));  % 0到2秒的波型
x2 = 3*sin(2*pi*8*t(t > 2 & t <= 5)) + 7*sin(2*pi*17*t(t > 2 & t <= 5));            % 3到5秒的波型

% 合併波型
x = [x1 x2];

% 繪製波型
figure;
plot(t, x);
title('樣本波型');
xlabel('時間 (秒)');
ylabel('振幅');
grid on;

% 計算並繪製 STFT
win = hamming(256);     % 使用 Hamming 窗口
noverlap = 128;         % 重疊部分
nfft = 512;             % FFT 點數

[~, f, t_stft, ps] = spectrogram(x, win, noverlap, nfft, Fs);

% 繪製 STFT 圖，不使用 dB
figure;
surf(t_stft, f, abs(ps), 'EdgeColor', 'none');
axis xy; axis tight; view(0, 90);
title('短時傅里葉變換 (STFT)');
xlabel('時間 (秒)');
ylabel('頻率 (Hz)');
colorbar;
ylabel(colorbar, '振幅');
