close all
%第三次腦波數據(Wardrobe) 何翊 2CH CH1:CZ CH2:FZ
data_Wardrobe = load('/Users/hoyi/Desktop/rrr/mat檔/20240715131051_test_bleEXGdata_Wardrobe.mat');
data_Wardrobe = data_Wardrobe.data;
data_Wardrobe = data_Wardrobe';
cz_signal_Wardrobe = data_Wardrobe(:, 1); 
fs = 250;
window = hamming(250);
noverlap = 125; 
nfft = 256; 
total_time_Wardrobe = length(cz_signal_Wardrobe) / fs;
% fprintf('Wardrobe整段時間: %.f 秒\n', total_time_Wardrobe);
% fprintf('Wardrobe的data長度: %.f\n', size(cz_signal_Wardrobe));

% Wardrobe在Cz的STFT
[cz_s_Wardrobe, cz_f_Wardrobe, cz_t_Wardrobe, cz_p_Wardrobe] = spectrogram(cz_signal_Wardrobe, window, noverlap, nfft, fs,'Power');
start_time_Wardrobe = 0;
end_time_Wardrobe = total_time_Wardrobe;

% % Wardrobe在Cz的頻譜圖
% figure;
% subplot(2,1,1);
% surf(cz_t_Wardrobe, cz_f_Wardrobe, 10*log10(abs(cz_p_Wardrobe)), 'EdgeColor', 'none');
% axis tight;
% ylim([0 60]);
% xlim([start_time_Wardrobe end_time_Wardrobe])  %秒數區段
% xticks(start_time_Wardrobe:20:end_time_Wardrobe) %每幾秒顯示一個刻度
% view(0, 90);
% colorbar;
% title('CZ Spectrogram');
% xlabel('Time (sec)');
% ylabel('Frequency (Hz)');
% caxis([-10 20]);
% colormap(jet);

score_Wardrobe(1:60) = 0;
score_Wardrobe(61:106) = 1;
score_Wardrobe(106:109) = 4;
score_Wardrobe(110:119) = 3;
score_Wardrobe(120:125) = 2;
score_Wardrobe(126:128) = 6;
score_Wardrobe(129:149) = 4;
score_Wardrobe(150:152) = 5;
score_Wardrobe(153:158) = 4;
score_Wardrobe(159:174) = 5;
score_Wardrobe(175:210) = 5;
score_Wardrobe(211:235) = 4;
score_Wardrobe(236:244) = 5;
score_Wardrobe(245:255) = 6;
score_Wardrobe(256:259) = 7;
score_Wardrobe(360:270) = 4;
score_Wardrobe(271:310) = 3;
score_Wardrobe(311:340) = 5;
score_Wardrobe(341:370) = 4;
score_Wardrobe(341:370) = 4;
score_Wardrobe(371:390) = 3;
score_Wardrobe(391:426) = 4;
%Beta波範圍
beta_freg_idx_Wardrobe = (cz_f_Wardrobe >= 12) & (cz_f_Wardrobe <= 28);
beta_cz_s_abs_Wardrobe = abs(cz_s_Wardrobe);
beta_selected_power_Wardrobe = beta_cz_s_abs_Wardrobe(beta_freg_idx_Wardrobe, :);
beta_mean_Wardrobe = mean(beta_selected_power_Wardrobe,1);

%Alpha波範圍
alpha_freg_idx_Wardrobe = (cz_f_Wardrobe >= 8) & (cz_f_Wardrobe <= 12);
alpha_cz_s_abs_Wardrobe = abs(cz_s_Wardrobe);
alpha_selected_power_Wardrobe = alpha_cz_s_abs_Wardrobe(alpha_freg_idx_Wardrobe, :);
alpha_mean_Wardrobe = mean(alpha_selected_power_Wardrobe,1);


% 如果Wardrobe的長度是奇數，刪除最後5個元素，若是偶數，刪除最後4個元素
if mod(length(beta_mean_Wardrobe), 2) ~= 0
    beta_mean_Wardrobe(length(beta_mean_Wardrobe)-8:end) = [];
    alpha_mean_Wardrobe(length(alpha_mean_Wardrobe)-8:end) = [];
else 
    beta_mean_Wardrobe(length(beta_mean_Wardrobe)-7:end) = [];
    alpha_mean_Wardrobe(length(alpha_mean_Wardrobe)-7:end) = [];
end

% 將Wardrobe中的每兩列數值平均
beta_mean_Wardrobe = mean(reshape(beta_mean_Wardrobe, 2, []), 1);
alpha_mean_Wardrobe = mean(reshape(alpha_mean_Wardrobe, 2, []), 1);
% 
% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean_Wardrobe);
% figure;
% subplot(2,1,1);
% plot(time_for_s, beta_mean_Wardrobe, 'LineWidth', 2);
% title('Wardrobe 12~28Hz能量');
% xlabel('資料點');
% ylim([10 100]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean_Wardrobe);
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_Wardrobe, 'LineWidth', 2);
% title('Wardrobe 8~12Hz能量');
% xlabel('資料點');
% ylim([10 200]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;


total_data_Wardrobe = length(beta_mean_Wardrobe);
fprintf('Wardrobe資料點總數量:');
disp(total_data_Wardrobe);

delete_data_Wardrobe = 0;

% 將Wardrobe前60列存成新變數
beta_mean_baseline_Wardrobe = beta_mean_Wardrobe(1:60);
alpha_mean_baseline_Wardrobe = alpha_mean_Wardrobe(1:60);

% 計算 Q1, Q3 和 IQR
beta_Q1_Wardrobe= prctile(beta_mean_baseline_Wardrobe, 25);  % 第 25 百分位數
beta_Q3_Wardrobe = prctile(beta_mean_baseline_Wardrobe, 75);  % 第 75 百分位數
beta_IQR_Wardrobe= beta_Q3_Wardrobe - beta_Q1_Wardrobe;  % 四分位距

alpha_Q1_Wardrobe = prctile(alpha_mean_baseline_Wardrobe, 25);  % 第 25 百分位數
alpha_Q3_Wardrobe = prctile(alpha_mean_baseline_Wardrobe, 75);  % 第 75 百分位數
alpha_IQR_Wardrobe = alpha_Q3_Wardrobe - alpha_Q1_Wardrobe;  % 四分位距

% 計算離群值上下界
beta_lower_bound_Wardrobe  = beta_Q1_Wardrobe- 1.5 * beta_IQR_Wardrobe;
beta_upper_bound_Wardrobe  = beta_Q3_Wardrobe + 1.5 * beta_IQR_Wardrobe;

alpha_lower_bound_Wardrobe = alpha_Q1_Wardrobe - 1.5 * alpha_IQR_Wardrobe;
alpha_upper_bound_Wardrobe = alpha_Q3_Wardrobe + 1.5 * alpha_IQR_Wardrobe;

% 判斷哪些數值為離群值
beta_outliers_baseline_Wardrobe = (beta_mean_baseline_Wardrobe < beta_lower_bound_Wardrobe ) | (beta_mean_baseline_Wardrobe > beta_upper_bound_Wardrobe );
alpha_outliers_baseline_Wardrobe = (alpha_mean_baseline_Wardrobe < alpha_lower_bound_Wardrobe) | (alpha_mean_baseline_Wardrobe > alpha_upper_bound_Wardrobe);
% 
% % 將 alpha_outliers_baseline_Wardrobe 中為 1 的位置替換到 beta_outliers_baseline_Wardrobe 中
% beta_outliers_baseline_Wardrobe(alpha_outliers_baseline_Wardrobe == 1) = 1;
% outliers_baseline_Wardrobe = beta_outliers_baseline_Wardrobe;
% 
% % Wardrobe 的 baseline 離群值的數量
% % fprintf('Wardrobe 的 baseline 離群值的數量: %d\n', sum(outliers_baseline_Wardrobe));
% 
% % Wardrobe 的 baseline 離群值在矩陣中的位置
% outliers_positions_baseline_Wardrobe = find(outliers_baseline_Wardrobe);
% % fprintf('Wardrobe baseline 離群值的位置: ');
% % disp(outliers_positions_baseline_Wardrobe);
% 
% %Wardrobe將1-60s和整段資料的離群值刪除
% beta_mean_baseline_Wardrobe(outliers_positions_baseline_Wardrobe) = [];
% beta_mean_Wardrobe(outliers_positions_baseline_Wardrobe) = [];
% score_Wardrobe(outliers_positions_baseline_Wardrobe) = [];
% % %將baseline_Wardrobe長度和mean_Wardrobe一樣 但除了baseline範圍其他為0
% beta_mean_set0_Wardrobe = beta_mean_Wardrobe;
% beta_mean_set0_Wardrobe(length(beta_mean_baseline_Wardrobe) + 1:length(beta_mean_Wardrobe)) = 0;
% beta_mean_baseline_Wardrobe = beta_mean_set0_Wardrobe;
% 
% alpha_mean_baseline_Wardrobe(outliers_positions_baseline_Wardrobe) = [];
% alpha_mean_Wardrobe(outliers_positions_baseline_Wardrobe)=[];
% 
% alpha_mean_set0_Wardrobe = alpha_mean_Wardrobe;
% alpha_mean_set0_Wardrobe(length(alpha_mean_baseline_Wardrobe) + 1:length(alpha_mean_Wardrobe)) = 0;
% alpha_mean_baseline_Wardrobe = alpha_mean_set0_Wardrobe;
% 
% 
% delete_data_Wardrobe = delete_data_Wardrobe + sum(outliers_baseline_Wardrobe);
% 
% 
% % % Wardrobe baseline(1~60s)12-28Hz折線圖 還沒去體動
% % time_for_s = 1:length(beta_mean_Wardrobe);
% % figure;
% % subplot(2,1,1);
% % plot(time_for_s,beta_mean_Wardrobe, 'LineWidth', 2);
% % title('Wardrobe baseline(1~60s)12-28Hz折線圖 還沒去體動');
% % xlabel('Time (seconds)');
% % ylim([0 200]);
% % xlim([0 length(time_for_s)]); % 秒數區段
% % xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% % ylabel('能量');
% % grid on;
% % 
% % 
% % % Wardrobe baseline(1~60s)8-12Hz折線圖 還沒去體動
% % time_for_s = 1:length(alpha_mean_Wardrobe);
% % subplot(2,1,2);
% % plot(time_for_s, alpha_mean_Wardrobe, 'LineWidth', 2);
% % title('Wardrobe baseline(1~60s)8-12Hz折線圖 還沒去體動');
% % xlabel('Time (seconds)');
% % ylim([0 200]);
% % xlim([0 length(time_for_s)]);  % 秒數區段
% % xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% % ylabel('能量');
% % grid on;
% 
% %beta 刪除i+1為i 2倍的資料點
% % 初始化一個變數來存儲被刪掉的列的索引
% deleted_idx_Wardrobe = [];
% % 遍歷 beta_mean_baseline_Wardrobe，檢查是否下一列的值是目前列的值的2倍
% i_Wardrobe = 1;
% while i_Wardrobe < length(beta_mean_Wardrobe)
%     if beta_mean_Wardrobe(i_Wardrobe + 1) >= beta_mean_Wardrobe(i_Wardrobe) * 2
%         % 如果條件滿足，記錄被刪除的列的索引
%         deleted_idx_Wardrobe(end + 1) = i_Wardrobe + 1;
%         %刪除下一列
%         % fprintf('beta當前的值');
%         % disp(beta_mean_Wardrobe(i_Wardrobe));
%         % fprintf('beta被刪的值');
%         % disp(beta_mean_Wardrobe(i_Wardrobe + 1));
%         beta_mean_Wardrobe(i_Wardrobe + 1) = [];
%         alpha_mean_Wardrobe(i_Wardrobe + 1) = [];
%         beta_mean_baseline_Wardrobe(i_Wardrobe + 1) = [];
%         alpha_mean_baseline_Wardrobe(i_Wardrobe + 1) = [];
%         score_Wardrobe(i_Wardrobe + 1) = [];
%         % 不移動i, 以便重新檢查新的下一列
%     else
%         % 只有當沒有刪除列時，才移動到下一個元素
%         i_Wardrobe = i_Wardrobe + 1;
%     end
% end
% 
% delete_data_Wardrobe = delete_data_Wardrobe + length(deleted_idx_Wardrobe);
% % disp('Wardrobe beta i+1 為i 超過2倍:');
% % disp(length(deleted_idx_Wardrobe))
% deleted_idx_Wardrobe = [];
% 
% % 刪除i+1為i-2 超過3.5倍的資料點
% i_Wardrobe = 3;
% while i_Wardrobe < length(beta_mean_Wardrobe)
%    if beta_mean_Wardrobe(i_Wardrobe + 1) >= beta_mean_Wardrobe(i_Wardrobe - 2) * 3.5
%         % 如果條件滿足，記錄被刪除的列的索引
%         deleted_idx_Wardrobe(end + 1) = i_Wardrobe + 1;
%         % 刪除下一列
%         % fprintf('beta當前的值');
%         % disp(beta_mean_Wardrobe(i_Wardrobe + 1));
%         % fprintf('beta被刪的值');
%         % disp(beta_mean_Wardrobe(i_Wardrobe - 2));
%         beta_mean_Wardrobe(i_Wardrobe + 1) = [];
%         alpha_mean_Wardrobe(i_Wardrobe + 1) = [];
%         beta_mean_baseline_Wardrobe(i_Wardrobe + 1) = [];
%         alpha_mean_baseline_Wardrobe(i_Wardrobe + 1) = [];
%         score_Wardrobe(i_Wardrobe + 1) = [];
%         % 不移動i, 以便重新檢查新的下一列
%     else
%         % 只有當沒有刪除列時，才移動到下一個元素
%         i_Wardrobe = i_Wardrobe + 1;
%     end
% end
% 
% delete_data_Wardrobe = delete_data_Wardrobe + length(deleted_idx_Wardrobe);
% % disp('Wardrobe beta i+1為i-2 超過3.5倍：');
% % disp(length(deleted_idx_Wardrobe));
% deleted_idx_Wardrobe = [];
% 
% % alpha 刪除i+1為i 超過2倍的資料點
% i_Wardrobe = 1;
% while i_Wardrobe < length(alpha_mean_Wardrobe)
%    if alpha_mean_Wardrobe(i_Wardrobe + 1) >= alpha_mean_Wardrobe(i_Wardrobe) * 2
%         % 如果條件滿足，記錄被刪除的列的索引
%         deleted_idx_Wardrobe(end + 1) = i_Wardrobe + 1;
%         % 刪除下一列
%         % fprintf('alpha當前的值');
%         % disp(alpha_mean_Wardrobe(i_Wardrobe));
%         % fprintf('alpha被刪的值');
%         % disp(alpha_mean_Wardrobe(i_Wardrobe + 1));
%         beta_mean_Wardrobe(i_Wardrobe + 1) = [];
%         alpha_mean_Wardrobe(i_Wardrobe + 1) = [];
%         beta_mean_baseline_Wardrobe(i_Wardrobe + 1) = [];
%         alpha_mean_baseline_Wardrobe(i_Wardrobe + 1) = [];
%         score_Wardrobe(i_Wardrobe + 1) = [];
%         % 不移動i, 以便重新檢查新的下一列
%     else
%         % 只有當沒有刪除列時，才移動到下一個元素
%         i_Wardrobe = i_Wardrobe + 1;
%     end
% end
% 
% delete_data_Wardrobe = delete_data_Wardrobe + length(deleted_idx_Wardrobe);
% % disp('Wardrobe alpha i+1 為i 超過2倍:');
% % disp(length(deleted_idx_Wardrobe));
% deleted_idx_Wardrobe = [];
% 
% % alpha 刪除i+1為i-2 超過3.5倍的資料點
% i_Wardrobe = 3;
% while i_Wardrobe < length(alpha_mean_Wardrobe)
%    if alpha_mean_Wardrobe(i_Wardrobe + 1) >= alpha_mean_Wardrobe(i_Wardrobe - 2) * 3.5
%         % 如果條件滿足，記錄被刪除的列的索引
%         deleted_idx_Wardrobe(end + 1) = i_Wardrobe + 1;
%         % 刪除下一列
%         % fprintf('alpha當前的值');
%         % disp(alpha_mean_Wardrobe(i_Wardrobe + 1));
%         % fprintf('alpha被刪的值');
%         % disp(alpha_mean_Wardrobe(i_Wardrobe - 2));
%         beta_mean_Wardrobe(i_Wardrobe + 1) = [];
%         alpha_mean_Wardrobe(i_Wardrobe + 1) = [];
%         beta_mean_baseline_Wardrobe(i_Wardrobe + 1) = [];
%         alpha_mean_baseline_Wardrobe(i_Wardrobe + 1) = [];
%         score_Wardrobe(i_Wardrobe + 1) = [];
%         % 不移動i, 以便重新檢查新的下一列
%     else
%         % 只有當沒有刪除列時，才移動到下一個元素
%         i_Wardrobe = i_Wardrobe + 1;
%     end
% end
% 
% delete_data_Wardrobe = delete_data_Wardrobe + length(deleted_idx_Wardrobe);
% % disp('WWardrobe alpha i+1為i-2 超過3.5倍：');
% % disp(length(deleted_idx_Wardrobe));
% 
% % % 繪製調整後的折線圖Beta波
% % time_for_s = 1:length(beta_mean_Wardrobe);
% % figure;
% % subplot(2,1,1);
% % plot(time_for_s, beta_mean_Wardrobe, 'LineWidth', 2);
% % title('Wardrobe 12~28Hz 去除體動後');
% % xlabel('資料點');
% % ylim([10 100]);
% % xlim([0 length(time_for_s)]);  % 秒數區段
% % xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% % ylabel('能量');
% % grid on;
% % 
% % % 繪製調整後的折線圖Alpha波
% % time_for_s = 1:length(alpha_mean_Wardrobe);
% % subplot(2,1,2);
% % plot(time_for_s, alpha_mean_Wardrobe, 'LineWidth', 2);
% % title('Wardrobe 8~12Hz 去除體動後');
% % xlabel('資料點');
% % ylim([10 180]);
% % xlim([0 length(time_for_s)]);  % 秒數區段
% % xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% % ylabel('能量');
% % grid on;
% 
% 
% beta_mean_baseline_Wardrobe(beta_mean_baseline_Wardrobe == 0) = [];
% alpha_mean_baseline_Wardrobe(alpha_mean_baseline_Wardrobe == 0) = [];
% 
% %計算baseline平均
% beta_mean_mean_baseline_Wardrobe = mean(beta_mean_baseline_Wardrobe);
% alpha_mean_mean_baseline_Wardrobe = mean(alpha_mean_baseline_Wardrobe);
% 
% %將baseline從移除
% beta_mean_Wardrobe = beta_mean_Wardrobe(length(beta_mean_baseline_Wardrobe)+1:end);
% alpha_mean_Wardrobe = alpha_mean_Wardrobe(length(alpha_mean_baseline_Wardrobe)+1:end);
% score_Wardrobe = score_Wardrobe(length(beta_mean_baseline_Wardrobe)+1:end);
% %標準化
% beta_mean_Wardrobe = (beta_mean_Wardrobe - beta_mean_mean_baseline_Wardrobe) / beta_mean_mean_baseline_Wardrobe;
% alpha_mean_Wardrobe = (alpha_mean_Wardrobe - alpha_mean_mean_baseline_Wardrobe) / alpha_mean_mean_baseline_Wardrobe;
% 
% % % 繪製調整後的折線圖Beta波
% % time_for_s = 1:length(beta_mean_Wardrobe);
% % figure;
% % subplot(2,1,1);
% % plot(time_for_s, beta_mean_Wardrobe, 'LineWidth', 2);
% % title('Wardrobe 12~28Hz 標準化後');
% % xlabel('資料點');
% % ylim([-1 2.5]);
% % xlim([0 length(time_for_s)]);  % 秒數區段
% % xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% % ylabel('能量');
% % grid on;
% % 
% % % 繪製調整後的折線圖Alpha波
% % time_for_s = 1:length(alpha_mean_Wardrobe);
% % subplot(2,1,2);
% % plot(time_for_s, alpha_mean_Wardrobe, 'LineWidth', 2);
% % title('Wardrobe 8~12Hz 標準化後');
% % xlabel('資料點');
% % ylim([-1 2.5]);
% % xlim([0 length(time_for_s)]);  % 秒數區段
% % xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% % ylabel('能量');
% % grid on;
% 
% %Wardrobe alpha 移動平均
% beta_mean_Wardrobe = movmean(beta_mean_Wardrobe, 10);
% alpha_mean_Wardrobe = movmean(alpha_mean_Wardrobe,10);
% 
% %Wardrobe alpha 平均值
% alpha_mean_mean_Wardrobe = mean(alpha_mean_Wardrobe);
% 
% %Wardrobe alpha 標準差
% alpha_std_Wardrobe = std(alpha_mean_Wardrobe);
% 
% %Wardrobe alpha z分數
% alpha_z_score_Wardrobe = (alpha_mean_Wardrobe - alpha_mean_mean_Wardrobe) / alpha_std_Wardrobe;
% 
% % Wardrobe alpha 分類
% alpha_quantiles_Wardrobe = quantile(alpha_z_score_Wardrobe, 6);
% alpha_categories_Wardrobe = discretize(alpha_z_score_Wardrobe, [-Inf, alpha_quantiles_Wardrobe, Inf]);
% 
% %Wardrobe beta 平均值
% beta_mean_mean_Wardrobe = mean(beta_mean_Wardrobe);
% 
% %Wardrobe beta 標準差
% beta_std_Wardrobe = std(beta_mean_Wardrobe);
% 
% %Wardrobe beta z分數
% beta_z_score_Wardrobe = (beta_mean_Wardrobe - beta_mean_mean_Wardrobe) / beta_std_Wardrobe;
% 
% % Wardrobe beta 分類
% beta_quantiles_Wardrobe = quantile(beta_z_score_Wardrobe, 6);
% beta_categories_Wardrobe = discretize(beta_z_score_Wardrobe, [-Inf, beta_quantiles_Wardrobe, Inf]);
% 
% 
% fprintf('Wardrobe 刪除資料點總數：');
% disp(delete_data_Wardrobe);
% 
% fprintf('Wardrobe baseline扣除離群值後總數：');
% disp(length(beta_mean_baseline_Wardrobe));
% 
% fprintf('Wardrobe baseline離群值數量：');
% disp(60 - length(beta_mean_baseline_Wardrobe));
% 
% fprintf('Wardrobe 扣除baseline總數量：');
% disp(length(beta_mean_Wardrobe));
% 
% fprintf('Wardrobe 扣除baseline離群值數量：')
% disp(delete_data_Wardrobe - (60 - length(beta_mean_baseline_Wardrobe)))
% 
% 
% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean_Wardrobe);
% figure;
% subplot(2,1,1);
% plot(time_for_s, beta_mean_Wardrobe, 'LineWidth', 2);
% title('Wardrobe 12~28Hz能量');
% xlabel('資料點');
% ylim([-0.5 2.5]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean_Wardrobe);
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_Wardrobe, 'LineWidth', 2);
% title('Wardrobe 8~12Hz能量');
% xlabel('資料點');
% ylim([-0.5 2.5]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('能量');
% grid on;
% 
% beta_slope_Wardrobe = (diff(beta_mean_Wardrobe)) / 2.5;
% alpha_slope_Wardrobe = (diff(alpha_mean_Wardrobe)) / 2.5;
% 
% beta_slope_Wardrobe = movmean(beta_slope_Wardrobe, 10);
% alpha_slope_Wardrobe = movmean(alpha_slope_Wardrobe,10);
% 
% beta_slope_mean1_Wardrobe = mean(abs(beta_slope_Wardrobe(1:80))) * 2.5;
% alpha_slope_mean1_Wardrobe = mean(abs(alpha_slope_Wardrobe(1:80)))* 2.5;
% 
% beta_slope_mean2_Wardrobe = mean(abs(beta_slope_Wardrobe(80:105)))* 2.5;
% alpha_slope_mean2_Wardrobe = meanabs((alpha_slope_Wardrobe(80:105)))* 2.5;
% 
% beta_slope_mean3_Wardrobe = mean(abs(beta_slope_Wardrobe(105:185)))* 2.5;
% alpha_slope_mean3_Wardrobe = mean(abs(alpha_slope_Wardrobe(105:185)))* 2.5;
% 
% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_slope_Wardrobe);
% figure;
% subplot(2,1,1);
% plot(time_for_s, beta_slope_Wardrobe, 'LineWidth', 2);
% title('Wardrobe 12~28Hz 斜率');
% xlabel('資料點');
% ylim([-0.05 0.05]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('斜率');
% grid on;
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_slope_Wardrobe);
% subplot(2,1,2);
% plot(time_for_s,alpha_slope_Wardrobe, 'LineWidth', 2);
% title('Wardrobe 8~12Hz 斜率');
% xlabel('資料點');
% ylim([-0.05 0.05]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('斜率');
% grid on;
% 
% 
% beta_mean = [beta_mean_Wardrobe];
% alpha_mean = [alpha_mean_Wardrobe];
% combined_data1 = [beta_mean', alpha_mean',score_Wardrobe'];
% % 使用 kmeans 分群 (分成三群)
% rng(1); 
% num_clusters = 3;
% [idx1, C1] = kmeans(combined_data1, num_clusters);
% 
% colors = {[0.3010 0.7450 0.9330],[0.4660 0.6740 0.1880],[0.8500 0.3250 0.0980]}; % green,blue,red
% 
% % 繪製三維散佈圖
% figure;
% hold on;
% for i = 1:num_clusters
%     scatter3(combined_data1(idx1 == i, 1), combined_data1(idx1 == i, 2), combined_data1(idx1 == i, 3), 50, ...
%         'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i});
% end
% % 設定軸標籤
% title('Wardrobe K-means score');
% xlabel('Beta');
% ylabel('Alpha');
% zlabel('Scare');
% 
% % 顯示群組中心
% scatter3(C1(:,1), C1(:,2), C1(:,3), 200,'k', 'x', 'LineWidth', 2);
% legend({'驚嚇', '認真', '有壓力', '質心'},'Location', 'northeast');
% hold off;
% grid on;
% view(3);
% % 輸出分類和顏色對應
% for i = 1:num_clusters
%     fprintf('分類 %d 對應的顏色: [%f %f %f]\n', i, colors{i});
% end
% 
% clustered_data_orange1 = [combined_data1, idx1]; % 新矩陣包含原始數據和分群結果
% 
% 
% combined_data_alpha = [beta_mean', alpha_mean',alpha_categories_Wardrobe'];
% % 使用 kmeans 分群 (分成三群)
% rng(1); 
% num_clusters = 3;
% [idx_alpha, C_alpha] = kmeans(combined_data_alpha, num_clusters);
% 
% colors = {[0.3010 0.7450 0.9330],[0.4660 0.6740 0.1880],[0.8500 0.3250 0.0980]}; % green,blue,red
% 
% % 繪製三維散佈圖
% figure;
% hold on;
% for i = 1:num_clusters
%     scatter3(combined_data_alpha(idx_alpha == i, 1), combined_data_alpha(idx_alpha == i, 2), combined_data_alpha(idx_alpha == i, 3), 50, ...
%         'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i});
% end
% % 設定軸標籤
% title('Wardrobe K-means alpha');
% xlabel('Beta');
% ylabel('Alpha');
% zlabel('Scare');
% 
% % 顯示群組中心
% scatter3(C_alpha(:,1), C_alpha(:,2), C_alpha(:,3), 200,'k', 'x', 'LineWidth', 2);
% legend({'驚嚇', '認真', '有壓力', '質心'},'Location', 'northeast');
% hold off;
% grid on;
% view(3);
% 
% % 輸出分類和顏色對應
% for i = 1:num_clusters
%     fprintf('分類 %d 對應的顏色: [%f %f %f]\n', i, colors{i});
% end
% 
% clustered_data_orange2 = [combined_data_alpha, idx_alpha]; % 新矩陣包含原始數據和分群結果
% 
% 
% combined_data_beta = [beta_mean', alpha_mean',beta_categories_Wardrobe'];
% % 使用 kmeans 分群 (分成三群)
% rng(1); 
% num_clusters = 3;
% [idx_beta, C_beta] = kmeans(combined_data_beta, num_clusters);
% 
% colors = {[0.3010 0.7450 0.9330],[0.4660 0.6740 0.1880],[0.8500 0.3250 0.0980]}; % green,blue,red
% 
% % 繪製三維散佈圖
% figure;
% hold on;
% for i = 1:num_clusters
%     scatter3(combined_data_beta(idx_beta == i, 1), combined_data_beta(idx_beta == i, 2), combined_data_beta(idx_beta == i, 3), 50, ...
%         'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i});
% end
% % 設定軸標籤
% title('Wardrobe K-means beta');
% xlabel('Beta');
% ylabel('Alpha');
% zlabel('Scare');
% 
% % 顯示群組中心
% scatter3(C_beta(:,1), C_beta(:,2), C_beta(:,3), 200,'k', 'x', 'LineWidth', 2);
% legend({'驚嚇', '認真', '有壓力', '質心'},'Location', 'northeast');
% hold off;
% grid on;
% view(3);
% 
% % 輸出分類和顏色對應
% for i = 1:num_clusters
%     fprintf('分類 %d 對應的顏色: [%f %f %f]\n', i, colors{i});
% end
% clustered_data_orange3 = [combined_data_beta, idx_beta]; % 新矩陣包含原始數據和分群結果
% 
% 
% % 提取分群结果（假设最后一列是分群标签）
% labels1 = clustered_data_orange1(:, end); % 从 orange1 提取的分群标签
% labels2 = clustered_data_orange3(:, end); % 从 orange2 提取的正确答案标签
% 
% % 計算准确率（简单比较两个标签的相同之处）
% accuracy = sum(labels1 == labels2) / length(labels1);
% 
% % 顯示結果
% fprintf('模型的准确率: %.2f%%\n', accuracy * 100);
% 
% % 假設你已經有了 clustered_data_orange1 和 clustered_data_orange2
% 
% % 確保兩個數據集的大小相同
% if size(clustered_data_orange1, 1) ~= size(clustered_data_orange3, 1)
%     error('兩個數據集大小不一致，請檢查數據!');
% end
% 
% % 提取分群結果（假設最後一列是分群標籤）
% labels1 = clustered_data_orange1(:, end); % 從 orange1 提取的分群標籤
% labels2 = clustered_data_orange3(:, end); % 從 orange2 提取的正確答案標籤
% 
% % 計算混淆矩陣
% conf_matrix = confusionmat(labels2, labels1);
% 
% % 顯示混淆矩陣
% disp('混淆矩陣:');
% disp(conf_matrix);
% 
% % 顯示分類報告
% accuracy = sum(labels1 == labels2) / length(labels1);
% fprintf('模型的準確率: %.2f%%\n', accuracy * 100);
% 
