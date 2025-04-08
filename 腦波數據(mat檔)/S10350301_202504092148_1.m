close all
data_S10350301_1 = load('/Users/hoyi/Downloads/S10350301_202504092148_1.mat');
data_S10350301_1 = data_S10350301_1.data;
data_S10350301_1 = data_S10350301_1';
cz_signal_S10350301_1 = data_S10350301_1(:, 1); 
fz_signal_S10350301_1 = data_S10350301_1(:, 2); 
fs = 250;
window = hamming(250);
noverlap = 125; 
nfft = 256; 
total_time_S10350301_1 = length(cz_signal_S10350301_1) / fs;
fprintf('S10350301_1整段時間: %.f 秒\n', total_time_S10350301_1);
fprintf('S10350301_1的data長度: %.f\n', size(cz_signal_S10350301_1));

% S10350301_1在Cz的STFT
[cz_s_S10350301_1, cz_f_S10350301_1, cz_t_S10350301_1, cz_p_S10350301_1] = spectrogram(cz_signal_S10350301_1, window, noverlap, nfft, fs,'Power');
[fz_s_S10350301_1, fz_f_S10350301_1, fz_t_S10350301_1, fz_p_S10350301_1] = spectrogram(fz_signal_S10350301_1, window, noverlap, nfft, fs,'Power');
start_time_S10350301_1 = 0;
end_time_S10350301_1 = total_time_S10350301_1;

% % S10350301_1在Cz的頻譜圖
% figure;
% subplot(2,1,1);
% surf(cz_t_S10350301_1, cz_f_S10350301_1, 10*log10(abs(cz_p_S10350301_1)), 'EdgeColor', 'none');
% axis tight;
% ylim([0 60]);
% xlim([start_time_S10350301_1 end_time_S10350301_1])  %秒數區段
% xticks(start_time_S10350301_1:20:end_time_S10350301_1) %每幾秒顯示一個刻度
% view(0, 90);
% colorbar;
% title('CZ Spectrogram');
% xlabel('Time (sec)');
% ylabel('Frequency (Hz)');
% caxis([-10 20]);
% colormap(jet);
% 
% % S10350301_1在fz的頻譜圖
% subplot(2,1,2);
% surf(fz_t_S10350301_1, fz_f_S10350301_1, 10*log10(abs(fz_p_S10350301_1)), 'EdgeColor', 'none');
% axis tight;
% ylim([0 60]);
% xlim([start_time_S10350301_1 end_time_S10350301_1])  %秒數區段
% xticks(start_time_S10350301_1:20:end_time_S10350301_1) %每幾秒顯示一個刻度
% view(0, 90);
% colorbar;
% title('FZ Spectrogram');
% xlabel('Time (sec)');
% ylabel('Frequency (Hz)');
% caxis([-10 20]);
% colormap(jet);


score_S10350301_1(1:65) = 1;
score_S10350301_1(66:73) = 2;
score_S10350301_1(74:81) = 3;
score_S10350301_1(82:96) = 4;
score_S10350301_1(97:98) = 5;

%Beta波範圍
beta_freg_idx_S10350301_1 = (cz_f_S10350301_1 >= 12) & (cz_f_S10350301_1 <= 28);
beta_cz_s_abs_S10350301_1 = abs(cz_s_S10350301_1);
beta_selected_power_S10350301_1 = beta_cz_s_abs_S10350301_1(beta_freg_idx_S10350301_1, :);
beta_mean_S10350301_1 = mean(beta_selected_power_S10350301_1,1);

%Alpha波範圍
alpha_freg_idx_S10350301_1 = (cz_f_S10350301_1 >= 8) & (cz_f_S10350301_1 <= 12);
alpha_cz_s_abs_S10350301_1 = abs(cz_s_S10350301_1);
alpha_selected_power_S10350301_1 = alpha_cz_s_abs_S10350301_1(alpha_freg_idx_S10350301_1, :);
alpha_mean_S10350301_1 = mean(alpha_selected_power_S10350301_1,1);


% 如果S10350301_1的長度是奇數，刪除最後5個元素，若是偶數，刪除最後4個元素
if mod(length(beta_mean_S10350301_1), 2) ~= 0
    beta_mean_S10350301_1(length(beta_mean_S10350301_1)-8:end) = [];
    alpha_mean_S10350301_1(length(alpha_mean_S10350301_1)-8:end) = [];
else 
    beta_mean_S10350301_1(length(beta_mean_S10350301_1)-7:end) = [];
    alpha_mean_S10350301_1(length(alpha_mean_S10350301_1)-7:end) = [];
end

% 將S10350301_1中的每兩列數值平均
beta_mean_S10350301_1 = mean(reshape(beta_mean_S10350301_1, 2, []), 1);
alpha_mean_S10350301_1 = mean(reshape(alpha_mean_S10350301_1, 2, []), 1);

%刪除最後兩束(end~98s)
beta_mean_S10350301_1 = beta_mean_S10350301_1(1:end-2);
alpha_mean_S10350301_1 = alpha_mean_S10350301_1(1:end-2);


% beta_mean_S10350301_1 = movmean(beta_mean_S10350301_1,3);
% alpha_mean_S10350301_1 = movmean(alpha_mean_S10350301_1,3);

% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean_S10350301_1);
% figure;
% subplot(2,1,1);
% plot(time_for_s, beta_mean_S10350301_1, 'LineWidth', 2);
% title('S10350301_1 beta 去除離群值前','FontSize', 26);
% xlabel('資料點');
% ylim([0 200]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean_S10350301_1);
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_S10350301_1, 'LineWidth', 2);
% title('S10350301_1 alpha 去除離群值前','FontSize', 26);
% xlabel('資料點');
% ylim([0 400]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;

total_data_S10350301_1 = length(beta_mean_S10350301_1);
fprintf('S10350301_1資料點總數量:');
disp(total_data_S10350301_1);

delete_data_S10350301_1 = 0;

% 計算 Q1, Q3 和 IQR
beta_Q1_S10350301_1= prctile(beta_mean_S10350301_1, 25);  % 第 25 百分位數
beta_Q3_S10350301_1 = prctile(beta_mean_S10350301_1, 75);  % 第 75 百分位數
beta_IQR_S10350301_1= beta_Q3_S10350301_1 - beta_Q1_S10350301_1;  % 四分位距

alpha_Q1_S10350301_1 = prctile(alpha_mean_S10350301_1, 25);  % 第 25 百分位數
alpha_Q3_S10350301_1 = prctile(alpha_mean_S10350301_1, 75);  % 第 75 百分位數
alpha_IQR_S10350301_1 = alpha_Q3_S10350301_1 - alpha_Q1_S10350301_1;  % 四分位距

% 計算離群值上下界
beta_lower_bound_S10350301_1  = beta_Q1_S10350301_1- 1.5 * beta_IQR_S10350301_1;
beta_upper_bound_S10350301_1  = beta_Q3_S10350301_1 + 1.5 * beta_IQR_S10350301_1;

alpha_lower_bound_S10350301_1 = alpha_Q1_S10350301_1 - 1.5 * alpha_IQR_S10350301_1;
alpha_upper_bound_S10350301_1 = alpha_Q3_S10350301_1 + 1.5 * alpha_IQR_S10350301_1;

% 判斷哪些數值為離群值
beta_outliers_S10350301_1 = (beta_mean_S10350301_1 < beta_lower_bound_S10350301_1 ) | (beta_mean_S10350301_1 > beta_upper_bound_S10350301_1 );
alpha_outliers_S10350301_1 = (alpha_mean_S10350301_1 < alpha_lower_bound_S10350301_1) | (alpha_mean_S10350301_1 > alpha_upper_bound_S10350301_1);
outliers_S10350301_1 = intersect(find(beta_outliers_S10350301_1 == 1), find(alpha_outliers_S10350301_1 == 1));

% 將S10350301_1前66列存成新變數
beta_mean_baseline_S10350301_1 = beta_mean_S10350301_1(1:66);
alpha_mean_baseline_S10350301_1 = alpha_mean_S10350301_1(1:66);

% %S10350301_1將1-66s和整段資料的離群值刪除
beta_mean_baseline_S10350301_1(outliers_S10350301_1 <= 66) = [];
alpha_mean_baseline_S10350301_1(outliers_S10350301_1 <= 66) = [];
beta_mean_S10350301_1(outliers_S10350301_1) = [];
score_S10350301_1(outliers_S10350301_1) = [];
alpha_mean_S10350301_1(outliers_S10350301_1)=[];

delete_data_S10350301_1 = delete_data_S10350301_1 + sum(outliers_S10350301_1);

% %將baseline_S10350301_1長度和mean_S10350301_1一樣 但除了baseline範圍其他為0
beta_mean_set0_S10350301_1 = beta_mean_S10350301_1;
beta_mean_set0_S10350301_1(length(beta_mean_baseline_S10350301_1) + 1:length(beta_mean_S10350301_1)) = 0;
beta_mean_baseline_S10350301_1 = beta_mean_set0_S10350301_1;

alpha_mean_set0_S10350301_1 = alpha_mean_S10350301_1;
alpha_mean_set0_S10350301_1(length(alpha_mean_baseline_S10350301_1) + 1:length(alpha_mean_S10350301_1)) = 0;
alpha_mean_baseline_S10350301_1 = alpha_mean_set0_S10350301_1;

% % S10350301_1 baseline(1~60s)12-28Hz折線圖 去除離群值
% time_for_s = 1:length(beta_mean_S10350301_1);
% figure;
% subplot(2,1,1);
% plot(time_for_s,beta_mean_S10350301_1, 'LineWidth', 2);
% title('S10350301_1 beta 刪除前','FontSize', 26);
% xlabel('Time (seconds)');
% ylim([0 200]);
% xlim([0 length(time_for_s)]); % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;
% 
% % S10350301_1 baseline(1~60s)8-12Hz折線圖 去除離群值
% time_for_s = 1:length(alpha_mean_S10350301_1);
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_S10350301_1, 'LineWidth', 2);
% title('S10350301_1 alpha 刪除前','FontSize', 26);
% xlabel('Time (seconds)');
% ylim([0 400]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;

%beta 刪除i+1為i 2倍的資料點
% 初始化一個變數來存儲被刪掉的列的索引
deleted_idx_S10350301_1 = [];
% 遍歷 beta_mean_baseline_S10350301_1，檢查是否下一列的值是目前列的值的2倍
i_S10350301_1 = 1;
while i_S10350301_1 < length(beta_mean_S10350301_1)
    if beta_mean_S10350301_1(i_S10350301_1 + 1) >= beta_mean_S10350301_1(i_S10350301_1) * 2 || ...
            alpha_mean_S10350301_1(i_S10350301_1 + 1) >= alpha_mean_S10350301_1(i_S10350301_1) * 2
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_S10350301_1(end + 1) = i_S10350301_1 + 1;
        %刪除下一列
        % fprintf('beta當前的值');
        % disp(beta_mean_S10350301_1(i_S10350301_1));
        % fprintf('beta被刪的值');
        % disp(beta_mean_S10350301_1(i_S10350301_1 + 1));
        % fprintf('alpha當前的值');
        % disp(alpha_mean_S10350301_1(i_S10350301_1));
        % fprintf('alpha被刪的值');
        % disp(alpha_mean_S10350301_1(i_S10350301_1 + 1));
        beta_mean_S10350301_1(i_S10350301_1 + 1) = [];
        beta_mean_baseline_S10350301_1(i_S10350301_1 + 1) = [];
        alpha_mean_S10350301_1(i_S10350301_1 + 1) = [];
        alpha_mean_baseline_S10350301_1(i_S10350301_1 + 1) = [];
        score_S10350301_1(i_S10350301_1 + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_S10350301_1 = i_S10350301_1 + 1;
    end
end

delete_data_S10350301_1 = delete_data_S10350301_1 + length(deleted_idx_S10350301_1);
% disp('S10350301_1 beta i+1 為i 超過2倍:');
% disp(length(deleted_idx_S10350301_1))

deleted_idx_S10350301_1 = [];
% 刪除i+1為i-2 超過3.5倍的資料點
i_S10350301_1 = 3;
while i_S10350301_1 < length(beta_mean_S10350301_1)
   if beta_mean_S10350301_1(i_S10350301_1 + 1) >= beta_mean_S10350301_1(i_S10350301_1 - 2) * 3.5 || ...
       alpha_mean_S10350301_1(i_S10350301_1 + 1) >= alpha_mean_S10350301_1(i_S10350301_1 - 2) * 3.5
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_S10350301_1(end + 1) = i_S10350301_1 + 1;
        % 刪除下一列
        fprintf('beta當前的值');
        disp(beta_mean_S10350301_1(i_S10350301_1 + 1));
        fprintf('beta被刪的值');
        disp(beta_mean_S10350301_1(i_S10350301_1 - 2));
        fprintf('alpha當前的值');
        disp(alpha_mean_S10350301_1(i_S10350301_1 + 1));
        fprintf('alpha被刪的值');
        disp(alpha_mean_S10350301_1(i_S10350301_1 - 2));
        beta_mean_S10350301_1(i_S10350301_1 + 1) = [];
        alpha_mean_S10350301_1(i_S10350301_1 + 1) = [];
        beta_mean_baseline_S10350301_1(i_S10350301_1 + 1) = [];
        alpha_mean_baseline_S10350301_1(i_S10350301_1 + 1) = [];
        score_S10350301_1(i_S10350301_1 + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_S10350301_1 = i_S10350301_1 + 1;
    end
end

delete_data_S10350301_1 = delete_data_S10350301_1 + length(deleted_idx_S10350301_1);
% disp('S10350301_1 beta i+1為i-2 超過3.5倍：');
% disp(length(deleted_idx_S10350301_1));
% % 
% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean_S10350301_1);
% figure;
% subplot(2,1,1);
% plot(time_for_s, beta_mean_S10350301_1, 'LineWidth', 2);
% title('S10350301_1 beta 標準化前','FontSize', 26);
% xlabel('資料點');
% ylim([0 200]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean_S10350301_1);
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_S10350301_1, 'LineWidth', 2);
% title('S10350301_1 alpha 標準化前','FontSize', 26);
% xlabel('資料點');
% ylim([0 400]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;

beta_mean_baseline_S10350301_1(beta_mean_baseline_S10350301_1 == 0) = [];
alpha_mean_baseline_S10350301_1(alpha_mean_baseline_S10350301_1 == 0) = [];

%計算baseline平均
beta_mean_mean_baseline_S10350301_1 = mean(beta_mean_baseline_S10350301_1);
alpha_mean_mean_baseline_S10350301_1 = mean(alpha_mean_baseline_S10350301_1);

%將baseline移除
beta_mean_S10350301_1 = beta_mean_S10350301_1(length(beta_mean_baseline_S10350301_1)+1:end);
alpha_mean_S10350301_1 = alpha_mean_S10350301_1(length(alpha_mean_baseline_S10350301_1)+1:end);
score_S10350301_1 = score_S10350301_1(length(beta_mean_baseline_S10350301_1)+1:end);

%標準化
beta_mean_S10350301_1 = (beta_mean_S10350301_1 - beta_mean_mean_baseline_S10350301_1) / beta_mean_mean_baseline_S10350301_1;
alpha_mean_S10350301_1 = (alpha_mean_S10350301_1 - alpha_mean_mean_baseline_S10350301_1) / alpha_mean_mean_baseline_S10350301_1;


% % S10350301_1 移動平均
beta_mean_S10350301_1 = movmean(beta_mean_S10350301_1, 6);
alpha_mean_S10350301_1 = movmean(alpha_mean_S10350301_1,6);

% 
% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean_S10350301_1);
% figure;
% subplot(2,1,1);
% plot(time_for_s, beta_mean_S10350301_1, 'LineWidth', 2);
% title('S10350301_1 beta 移動平均後','FontSize', 26);
% xlabel('資料點');
% ylim([-1 1.5]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;2
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean_S10350301_1);
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_S10350301_1, 'LineWidth', 2);
% title('S10350301_1 alpha 移動平均後','FontSize', 26);
% xlabel('資料點');
% ylim([-1 1.5]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;
% % % 
% % % % fprintf('S10350301_1 刪除資料點總數：');
% % % % disp(delete_data_S10350301_1);
% % % % 
% % % % fprintf('S10350301_1 baseline扣除離群值後總數：');
% % % % disp(length(beta_mean_baseline_S10350301_1));
% % % % 
% % % % fprintf('S10350301_1 baseline離群值數量：');
% % % % disp(60 - length(beta_mean_baseline_S10350301_1));
% % % % 
% % % % fprintf('S10350301_1 扣除baseline總數量：');
% % % % disp(length(beta_mean_S10350301_1));
% % % % 
% % % % fprintf('S10350301_1 扣除baseline離群值數量：')
% % % % disp(delete_data_S10350301_1 - (60 - length(beta_mean_baseline_S10350301_1)))

