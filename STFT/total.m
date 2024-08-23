%第四次腦波數據(Short Horror File) 周孟軒 4CH+G CH1:FZ CH3:CZ
data_Short = load('/Users/hoyi/Desktop/rrr/mat檔/Rawdatafile_20240813221410_bleEXGdata_Short.mat');
data_Short = data_Short.data;
data_Short = data_Short';
cz_signal_Short = data_Short(:, 1); 
fs = 250;
window = hamming(250);
noverlap = 125; 
nfft = 256; 
total_time_Short = length(cz_signal_Short) / fs;
% fprintf('Short整段時間: %.f 秒\n', total_time_Short);
% fprintf('Short的data長度: %.f\n', size(cz_signal_Short));

% Short在Cz的STFT
[cz_s_Short, cz_f_Short, cz_t_Short, cz_p_Short] = spectrogram(cz_signal_Short, window, noverlap, nfft, fs,'Power');

start_time_Short = 0;
end_time_Short = total_time_Short;

% % Short在Cz的頻譜圖
% figure;
% subplot(2,1,1);
% surf(cz_t_Short, cz_f_Short, 10*log10(abs(cz_p_Short)), 'EdgeColor', 'none');
% axis tight;
% ylim([0 60]);
% xlim([start_time_Short end_time_Short])  %秒數區段
% xticks(start_time_Short:20:end_time_Short) %每幾秒顯示一個刻度
% view(0, 90);
% colorbar;
% title('CZ Spectrogram');
% xlabel('Time (sec)');
% ylabel('Frequency (Hz)');
% caxis([-10 20]);
% colormap(jet);

beta_freg_idx_Short = (cz_f_Short >= 12) & (cz_f_Short <= 28);
beta_cz_s_abs_Short = abs(cz_s_Short);
beta_selected_power_Short = beta_cz_s_abs_Short(beta_freg_idx_Short, :);
beta_mean_Short = mean(beta_selected_power_Short,1);

%Alpha波
alpha_freg_idx_Short = (cz_f_Short >= 8) & (cz_f_Short <= 12);
alpha_cz_s_abs_Short = abs(cz_s_Short);
alpha_selected_power_Short = alpha_cz_s_abs_Short(alpha_freg_idx_Short, :);
alpha_mean_Short = mean(alpha_selected_power_Short,1);

% 如果Short的長度是奇數，刪除最後5個元素，若是偶數，刪除最後4個元素
if mod(length(beta_mean_Short), 2) ~= 0
    beta_mean_Short(length(beta_mean_Short)-8:end) = [];
    alpha_mean_Short(length(alpha_mean_Short)-8:end) = [];
else 
    beta_mean_Short(length(beta_mean_Short)-7:end) = [];
    alpha_mean_Short(length(alpha_mean_Short)-7:end) = [];
end

% 將Short中的每兩列數值平均
beta_mean_Short = mean(reshape(beta_mean_Short, 2, []), 1);
alpha_mean_Short = mean(reshape(alpha_mean_Short, 2, []), 1);


total_data_Short = length(beta_mean_Short);
fprintf('Short資料點總數量:');
disp(total_data_Short);

delete_data_Short = 0;

% 將Short前60列存成新變數
beta_mean_baseline_Short = beta_mean_Short(1:60);
alpha_mean_baseline_Short = alpha_mean_Short(1:60);

% % Short baseline(1~60s)12-28Hz折線圖 還沒去體動
% time_for_s = 1:length(beta_mean_baseline_Short);
% figure;
% subplot(2,1,1);
% plot(time_for_s,beta_mean_baseline_Short, 'LineWidth', 2);
% title('Short baseline(1~60s)12-28Hz折線圖 還沒去體動');
% xlabel('Time (seconds)');
% ylim([15 100]);
% xlim([0 length(time_for_s)]); % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;
% 
% 
% % Short baseline(1~60s)8-12Hz折線圖 還沒去體動
% time_for_s = 1:length(alpha_mean_baseline_Short);
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_baseline_Short, 'LineWidth', 2);
% title('Short baseline(1~60s)8-12Hz折線圖 還沒去體動');
% xlabel('Time (seconds)');
% ylim([15 100]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;


% 將 beta 和 alpha 數據組合成一個矩陣
boxes_combined_data_baseline_Short = [beta_mean_baseline_Short', alpha_mean_baseline_Short'];

% % 繪製盒狀圖
% figure;
% boxplot(boxes_combined_data_baseline_Short, 'Labels', {'Beta(12-28Hz)', 'Alpha(8-12Hz)'}, ...
%     'OutlierSize', 20, ...  % 調整離群值大小
%     'Symbol', '*', ...      % 設置離群值的符號
%     'Colors', 'b');         % 設置箱型圖的顏色（但不會影響離群值）
% 
% % 获取箱型图的图形句柄
% h = findobj(gca, 'Tag', 'Outliers');
% % 将离群值的颜色加深
% set(h, 'MarkerEdgeColor', 'r', 'MarkerSize', 20);  % 設置為紅色，並增加大小
% 
% title('Short baseline(1~60s) 盒壯圖 12-28Hz 和 8-12Hz');
% ylabel('能量');
% xlabel('腦波類型');

% 計算 Q1, Q3 和 IQR
beta_Q1_Short= prctile(beta_mean_baseline_Short, 25);  % 第 25 百分位數
beta_Q3_Short = prctile(beta_mean_baseline_Short, 75);  % 第 75 百分位數
beta_IQR_Short= beta_Q3_Short - beta_Q1_Short;  % 四分位距

alpha_Q1_Short = prctile(alpha_mean_baseline_Short, 25);  % 第 25 百分位數
alpha_Q3_Short = prctile(alpha_mean_baseline_Short, 75);  % 第 75 百分位數
alpha_IQR_Short = alpha_Q3_Short - alpha_Q1_Short;  % 四分位距

% 計算離群值上下界
beta_lower_bound_Short  = beta_Q1_Short- 1.5 * beta_IQR_Short;
beta_upper_bound_Short  = beta_Q3_Short + 1.5 * beta_IQR_Short;

alpha_lower_bound_Short = alpha_Q1_Short - 1.5 * alpha_IQR_Short;
alpha_upper_bound_Short = alpha_Q3_Short + 1.5 * alpha_IQR_Short;

% 判斷哪些數值為離群值
beta_outliers_baseline_Short = (beta_mean_baseline_Short < beta_lower_bound_Short ) | (beta_mean_baseline_Short > beta_upper_bound_Short );
alpha_outliers_baseline_Short = (alpha_mean_baseline_Short < alpha_lower_bound_Short) | (alpha_mean_baseline_Short > alpha_upper_bound_Short);

% % 繪製 Short baseline beta離群值折線圖
% time_for_s = 1:length(beta_mean_baseline_Short);
% figure;
% subplot(2,1,1);
% plot(time_for_s, beta_mean_baseline_Short, '-b', 'LineWidth', 1.5); % 藍色線條
% hold on;
% 
% % 將離群值用紅色圓點標示出來
% plot(time_for_s(beta_outliers_baseline_Short),beta_mean_baseline_Short(beta_outliers_baseline_Short), 'ro', 'MarkerSize', 40);
% 
% title('Short baseline(1~60s)12-28Hz折線圖 標示離群值');
% xlabel('時間 (秒)');
% ylabel('能量');
% ylim([10 100]);
% hold off;
% 
% % 繪製 Short baseline alpha 離群值折線圖
% time_for_s = 1:length(alpha_mean_baseline_Short);
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_baseline_Short, '-b', 'LineWidth', 1.5); % 藍色線條
% hold on;
% 
% % 將離群值用紅色圓點標示出來
% plot(time_for_s(alpha_outliers_baseline_Short),alpha_mean_baseline_Short(alpha_outliers_baseline_Short), 'ro', 'MarkerSize', 40);
% title('Short baseline(1~60s)8-12Hz折線圖 標示離群值');
% xlabel('時間 (秒)');
% ylabel('能量');
% ylim([10 100]);
% hold off;

% 將 alpha_outliers_baseline_Short 中為 1 的位置替換到 beta_outliers_baseline_Short 中
beta_outliers_baseline_Short(alpha_outliers_baseline_Short == 1) = 1;
outliers_baseline_Short = beta_outliers_baseline_Short;

% Short 的 baseline 離群值的數量
% fprintf('Short 的 baseline 離群值的數量: %d\n', sum(outliers_baseline_Short));

% Short 的 baseline 離群值在矩陣中的位置
outliers_positions_baseline_Short = find(outliers_baseline_Short);
fprintf('Short baseline 離群值的位置: ');
disp(outliers_positions_baseline_Short);

%Short將1-60s離群值刪除
beta_mean_baseline_Short(outliers_positions_baseline_Short) = [];
beta_mean_Short(outliers_positions_baseline_Short) = [];

alpha_mean_baseline_Short(outliers_positions_baseline_Short) = [];
alpha_mean_Short(outliers_positions_baseline_Short)=[];

delete_data_Short = delete_data_Short + sum(outliers_baseline_Short);


%第一輪Short baseline 平移
%beta 
%找到最小值 計算偏移量 如果最小值比0小 將最小值平移至0.1 其他數值向上平移
beta_mean_baseline_move_Short = beta_mean_baseline_Short;
if min(beta_mean_baseline_Short) < 0
    beta_mean_baseline_offset_Short = abs(min(beta_mean_baseline_Short));
else
    beta_mean_baseline_offset_Short = 0;
end
beta_mean_baseline_move_Short = beta_mean_baseline_move_Short + beta_mean_baseline_offset_Short + 0.1;

%計算中位數 並將小於中位數的所有點替換為中位數
beta_mean_baseline_move_median_Short = median(beta_mean_baseline_move_Short);
beta_mean_baseline_move_Short(beta_mean_baseline_move_Short <beta_mean_baseline_move_median_Short) =beta_mean_baseline_move_median_Short;

%alpha
alpha_mean_baseline_move_Short = alpha_mean_baseline_Short;
if min(alpha_mean_baseline_Short) < 0
   alpha_mean_baseline_offset_Short = abs(min(alpha_mean_baseline_Short));
else
    alpha_mean_baseline_offset_Short = 0;
end
alpha_mean_baseline_move_Short = alpha_mean_baseline_move_Short +alpha_mean_baseline_offset_Short + 0.1;

alpha_mean_baseline_move_median_Short = median(alpha_mean_baseline_move_Short);
alpha_mean_baseline_move_Short(alpha_mean_baseline_move_Short < alpha_mean_baseline_move_median_Short) = alpha_mean_baseline_move_median_Short;

% 初始化一個變數來存儲被刪掉的列的索引
deleted_idx_Short = [];

% 遍歷 beta_mean_baseline_move_Short，檢查是否下一列的值是目前列的值的2倍
i_Short = 1;
while i_Short < length(beta_mean_baseline_move_Short)
    if beta_mean_baseline_move_Short(i_Short + 1) >= 2 * beta_mean_baseline_move_Short(i_Short)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Short(end + 1) = i_Short + 1;
        %刪除下一列
        % fprintf('當前的值');
        % disp(beta_mean_baseline_move_Short(i_Short));
        % fprintf('被刪的值');
        disp(beta_mean_baseline_move_Short(i_Short + 1));
        beta_mean_baseline_move_Short(i_Short + 1) = [];
        alpha_mean_baseline_move_Short(i_Short + 1) = [];
        beta_mean_baseline_Short(i_Short + 1) = [];
        alpha_mean_baseline_Short(i_Short + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Short = i_Short + 1;
    end
end

% disp('Short baseline 被刪掉的列的索引(Beta第一run):');
% disp(length(deleted_idx_Short));

delete_data_Short = delete_data_Short + length(deleted_idx_Short);
deleted_idx_Short = [];

% 遍歷 alpha_mean_baseline_move_Short，檢查是否下一列的值是目前列的值的2倍
i_Short = 1;
while i_Short < length(alpha_mean_baseline_move_Short)
    if alpha_mean_baseline_move_Short(i_Short + 1) >= 2 * alpha_mean_baseline_move_Short(i_Short)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Short(end + 1) = i_Short + 1;
        % 刪除下一列
        % fprintf('當前的值');
        % disp(alpha_mean_baseline_move_Short(i_Short));
        % fprintf('被刪的值');
        disp(alpha_mean_baseline_move_Short(i_Short + 1));
        alpha_mean_baseline_move_Short(i_Short + 1) = [];
        beta_mean_baseline_move_Short(i_Short + 1) = [];
        alpha_mean_baseline_Short(i_Short + 1) = [];
        beta_mean_baseline_Short(i_Short + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Short = i_Short + 1;
    end
end

delete_data_Short = delete_data_Short + length(deleted_idx_Short);
% % disp('Short被刪掉的列的索引(alpha第二run):');
% % disp(length(deleted_idx_Short));

%第二輪Short baseline 平移
%beta 
beta_mean_baseline_move_Short = beta_mean_baseline_Short;
if min(beta_mean_baseline_Short) < 0
    beta_mean_baseline_offset_Short = abs(min(beta_mean_baseline_Short));
else
    beta_mean_baseline_offset_Short = 0;
end
beta_mean_baseline_move_Short = beta_mean_baseline_move_Short + beta_mean_baseline_offset_Short;

%計算中位數 並將大於中位數的所有點替換為中位數
beta_mean_baseline_move_median_Short = median(beta_mean_baseline_move_Short);
beta_mean_baseline_move_Short(beta_mean_baseline_move_Short > beta_mean_baseline_move_median_Short) = beta_mean_baseline_move_median_Short;
% 找到比中位數小的
smaller_than_med_Short =beta_mean_baseline_move_Short < beta_mean_baseline_move_median_Short;
% 計算新值
new_values_Short = abs(beta_mean_baseline_move_median_Short - beta_mean_baseline_move_Short(smaller_than_med_Short)) + beta_mean_baseline_move_median_Short;
beta_mean_baseline_move_Short(smaller_than_med_Short) = new_values_Short;


%alpha
alpha_mean_baseline_move_Short = alpha_mean_baseline_Short;
if min(alpha_mean_baseline_Short) < 0
    alpha_mean_baseline_offset_Short = abs(min(alpha_mean_baseline_Short));
else
    alpha_mean_baseline_offset_Short = 0;
end
alpha_mean_baseline_move_Short = alpha_mean_baseline_move_Short + alpha_mean_baseline_offset_Short;

alpha_mean_baseline_move_median_Short = median(alpha_mean_baseline_move_Short);
alpha_mean_baseline_move_Short(alpha_mean_baseline_move_Short > alpha_mean_baseline_move_median_Short) = alpha_mean_baseline_move_median_Short;
% 找到比中位數小的
smaller_than_med_Short =alpha_mean_baseline_move_Short < alpha_mean_baseline_move_median_Short;
% 計算新值
new_values_Short = abs(alpha_mean_baseline_move_median_Short -alpha_mean_baseline_move_Short(smaller_than_med_Short)) +alpha_mean_baseline_move_median_Short;
alpha_mean_baseline_move_Short(smaller_than_med_Short) = new_values_Short;


% 初始化一個變數來存儲被刪掉的列的索引
deleted_idx_Short = [];

% 遍歷beta_mean_baseline_move_Short，檢查是否下一列的值是目前列的值的2倍
i_Short = 1;
while i_Short < length(beta_mean_baseline_move_Short)
    if beta_mean_baseline_move_Short(i_Short + 1) >= 2 * beta_mean_baseline_move_Short(i_Short)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Short(end + 1) = i_Short + 1;
        % 刪除下一列
        % fprintf('當前的值');
        % disp(beta_mean_baseline_move_Short(i_Short));
        % fprintf('被刪的值');
        disp(beta_mean_baseline_move_Short(i_Short + 1));
        beta_mean_baseline_move_Short(i_Short + 1) = [];
        alpha_mean_baseline_move_Short(i_Short + 1) = [];
        beta_mean_baseline_Short(i_Short + 1) = [];
        alpha_mean_baseline_Short(i_Short + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Short = i_Short + 1;
    end
end

delete_data_Short = delete_data_Short + length(deleted_idx_Short);
% disp('Short被刪掉的列的索引(Beta第三run):');
% disp(length(deleted_idx_Short));
deleted_idx_Short = [];

% 遍歷 alpha_mean_baseline_move_Shorty，檢查是否下一列的值是目前列的值的2倍
i_Short = 1;
while i_Short < length(alpha_mean_baseline_move_Short)
    if alpha_mean_baseline_move_Short(i_Short + 1) >= 2 * alpha_mean_baseline_move_Short(i_Short)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Short(end + 1) = i_Short + 1;
        % % 刪除下一列
        % fprintf('當前的值');
        % disp(alpha_mean_baseline_move_Short(i_Short));
        % fprintf('被刪的值');
        disp(alpha_mean_baseline_move_Short(i_Short + 1));
        alpha_mean_baseline_move_Short(i_Short + 1) = [];
        beta_mean_baseline_move_Short(i_Short + 1) = [];
        alpha_mean_baseline_Short(i_Short + 1) = [];
        beta_mean_baseline_Short(i_Short + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Short = i_Short + 1;
    end
end

delete_data_Short = delete_data_Short + length(deleted_idx_Short);
% fprintf('Short baseline被刪除資料點數量：');
% disp(delete_data_Short)
% disp('Short被刪掉的列的索引(alpha第四run):');
% disp(length(deleted_idx_Short));


%Short的baseline的平均值
beta_mean_mean_baseline_Short = mean(beta_mean_baseline_Short);
alpha_mean_mean_baseline_Short = mean(alpha_mean_baseline_Short);

% % Short baseline繪製柱狀圖
% figure;
% bar([beta_mean_mean_baseline_Short,alpha_mean_mean_baseline_Short]);
% title('Short baseline 平均能量');
% xlabel('腦波種類');
% ylabel('平均能量');
% set(gca, 'XTickLabel', {'beta波(12-28Hz)', 'alpha波(8-12Hz)'});
% grid on;


beta_mean_Short(1:length(beta_mean_baseline_Short)) = beta_mean_baseline_Short;
alpha_mean_Short(1:length(alpha_mean_baseline_Short)) = alpha_mean_baseline_Short;

%Short標準化
beta_mean_Short = beta_mean_Short - beta_mean_mean_baseline_Short;
beta_mean_Short = beta_mean_Short / beta_mean_mean_baseline_Short;

alpha_mean_Short = alpha_mean_Short - alpha_mean_mean_baseline_Short;
alpha_mean_Short = alpha_mean_Short / alpha_mean_mean_baseline_Short;


% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean_Short(55:end));
% figure;
% subplot(2,1,1);
% plot(time_for_s, beta_mean_Short(55:end), 'LineWidth', 2);
% title('Short 12~28Hz平均功率');
% xlabel('資料點');
% ylim([-1 5]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean_Short(55:end));
% subplot(2,1,2);
% plot(time_for_s, alpha_mean_Short(55:end), 'LineWidth', 2);
% title('Short 8~12Hz平均功率');
% xlabel('資料點');
% ylim([-1 5]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:5:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;
% 

%第一輪Short平移
%beta 
%找到最小值 計算偏移量 如果最小值比0小 將最小值平移至0.1 其他數值向上平移
beta_mean_move_Short = beta_mean_Short;
if min(beta_mean_Short) < 0
    beta_mean_offset_Short = abs(min(beta_mean_Short));
else
    beta_mean_offset_Short = 0;
end
beta_mean_move_Short = beta_mean_move_Short + beta_mean_offset_Short + 0.1;

%計算中位數 並將小於中位數的所有點替換為中位數
beta_mean_move_median_Short = median(beta_mean_move_Short);
beta_mean_move_Short(beta_mean_move_Short < beta_mean_move_median_Short) = beta_mean_move_median_Short;

%alpha
alpha_mean_move_Short = alpha_mean_Short;
if min(alpha_mean_Short) < 0
    alpha_mean_offset_Short = abs(min(alpha_mean_Short));
else
    alpha_mean_offset_Short = 0;
end
alpha_mean_move_Short = alpha_mean_move_Short + alpha_mean_offset_Short + 0.1;

alpha_mean_move_median_Short = median(alpha_mean_move_Short);
alpha_mean_move_Short(alpha_mean_move_Short < alpha_mean_move_median_Short) = alpha_mean_move_median_Short;


% 初始化一個變數來存儲被刪掉的列的索引
deleted_idx_Short = [];

% 遍歷 beta_mean_move_Short，檢查是否下一列的值是目前列的值的2倍
i_Short = 1;
while i_Short < length(beta_mean_move_Short)
    if beta_mean_move_Short(i_Short + 1) >= 2 * beta_mean_move_Short(i_Short)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Short(end + 1) = i_Short + 1;
        % % 刪除下一列
        % fprintf('當前的值');
        % disp(beta_mean_move_Short(i_Short));
        % fprintf('被刪的值');
        % disp(beta_mean_move_Short(i_Short + 1));
        beta_mean_move_Short(i_Short + 1) = [];
        alpha_mean_move_Short(i_Short + 1) = [];
        beta_mean_Short(i_Short + 1) = [];
        alpha_mean_Short(i_Short + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Short = i_Short + 1;
    end
end

% disp('Short被刪掉的列的索引(Beta第一run):');
% disp(length(deleted_idx_Short));

delete_data_Short = delete_data_Short + length(deleted_idx_Short);
deleted_idx_Short = [];

% 遍歷 alpha_mean_move_Short，檢查是否下一列的值是目前列的值的2倍
i_Short = 1;
while i_Short < length(alpha_mean_move_Short)
    if alpha_mean_move_Short(i_Short + 1) >= 2 * alpha_mean_move_Short(i_Short)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Short(end + 1) = i_Short + 1;
        % 刪除下一列
        % fprintf('當前的值');
        % disp(alpha_mean_move_Short(i_Short));
        % fprintf('被刪的值');
        % disp(alpha_mean_move_Short(i_Short + 1));
        alpha_mean_move_Short(i_Short + 1) = [];
        beta_mean_move_Short(i_Short + 1) = [];
        alpha_mean_Short(i_Short + 1) = [];
        beta_mean_Short(i_Short + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Short = i_Short + 1;
    end
end

delete_data_Short = delete_data_Short + length(deleted_idx_Short);
% disp('Short被刪掉的列的索引(alpha第二run):');
% disp(length(deleted_idx_Short));

% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean_move_Short);
% figure;
% subplot(2,1,1);
% plot(time_for_s,beta_mean_move_Short, 'LineWidth', 2);
% title('Short 12~28Hz平均功率(去除體動)(標準化)');
% xlabel('Time (seconds)');
% ylim([-1 2]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;
% 
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean_move_Short);
% subplot(2,1,2);
% plot(time_for_s,alpha_mean_move_Short, 'LineWidth', 2);
% title('Short 8~12Hz平均功率(去除體動)(標準化)');
% xlabel('Time (seconds)');
% ylim([-1 2]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;


%第二輪Short平移
%beta 
beta_mean_move_Short = beta_mean_Short;
if min(beta_mean_Short) < 0
    beta_mean_offset_Short = abs(min(beta_mean_Short));
else
    beta_mean_offset_Short = 0;
end
beta_mean_move_Short = beta_mean_move_Short + beta_mean_offset_Short;

%計算中位數 並將大於中位數的所有點替換為中位數
beta_mean_move_median_Short = median(beta_mean_move_Short);
beta_mean_move_Short(beta_mean_move_Short > beta_mean_move_median_Short) = beta_mean_move_median_Short;
% 找到比中位數小的
smaller_than_med_Short = beta_mean_move_Short < beta_mean_move_median_Short;
% 計算新值
new_values_Short = abs(beta_mean_move_median_Short - beta_mean_move_Short(smaller_than_med_Short)) + beta_mean_move_median_Short;
beta_mean_move_Short(smaller_than_med_Short) = new_values_Short;


%alpha
alpha_mean_move_Short = alpha_mean_Short;
if min(alpha_mean_Short) < 0
    alpha_mean_offset_Short = abs(min(alpha_mean_Short));
else
    alpha_mean_offset_Short = 0;
end
alpha_mean_move_Short = alpha_mean_move_Short + alpha_mean_offset_Short;

alpha_mean_move_median_Short = median(alpha_mean_move_Short);
alpha_mean_move_Short(alpha_mean_move_Short > alpha_mean_move_median_Short) = alpha_mean_move_median_Short;

% 找到比中位數小的
smaller_than_med_Short = alpha_mean_move_Short < alpha_mean_move_median_Short;
% 計算新值
new_values_Short = abs(alpha_mean_move_median_Short - alpha_mean_move_Short(smaller_than_med_Short)) + alpha_mean_move_median_Short;
alpha_mean_move_Short(smaller_than_med_Short) = new_values_Short;

% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean_move_Short);
% figure;
% subplot(2,1,1);
% plot(time_for_s,beta_mean_move_Short, 'LineWidth', 2);
% title('Short 12~28Hz平均功率(去除體動)(標準化)');
% xlabel('Time (seconds)');
% ylim([-1 2]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;
% 
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean_move_Short);
% subplot(2,1,2);
% plot(time_for_s,alpha_mean_move_Short, 'LineWidth', 2);
% title('Short 8~12Hz平均功率(去除體動)(標準化)');
% xlabel('Time (seconds)');
% ylim([-1 2]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;


% 初始化一個變數來存儲被刪掉的列的索引
deleted_idx_Short = [];

% 遍歷 beta_mean_move_Short，檢查是否下一列的值是目前列的值的2倍
i_Short = 1;
while i_Short < length(beta_mean_move_Short)
    if beta_mean_move_Short(i_Short + 1) >= 2 * beta_mean_move_Short(i_Short)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Short(end + 1) = i_Short + 1;
        % 刪除下一列
        % fprintf('當前的值');
        % disp(beta_mean_move_Short(i_Short));
        % fprintf('被刪的值');
        % disp(beta_mean_move_Short(i_Short + 1));
        beta_mean_move_Short(i_Short + 1) = [];
        alpha_mean_move_Short(i_Short + 1) = [];
        beta_mean_Short(i_Short + 1) = [];
        alpha_mean_Short(i_Short + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Short = i_Short + 1;
    end
end

delete_data_Short = delete_data_Short + length(deleted_idx_Short);
% disp('Short被刪掉的列的索引(Beta第三run):');
% disp(length(deleted_idx_Short));
deleted_idx_Short = [];

% 遍歷 alpha_mean_move_Short，檢查是否下一列的值是目前列的值的2倍
i_Short = 1;
while i_Short < length(alpha_mean_move_Short)
    if alpha_mean_move_Short(i_Short + 1) >= 2 * alpha_mean_move_Short(i_Short)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Short(end + 1) = i_Short + 1;
        % 刪除下一列
        % fprintf('當前的值');
        % disp(alpha_mean_move_Short(i_Short));
        % fprintf('被刪的值');
        % disp(alpha_mean_move_Short(i_Short + 1));
        alpha_mean_move_Short(i_Short + 1) = [];
        beta_mean_move_Short(i_Short + 1) = [];
        alpha_mean_Short(i_Short + 1) = [];
        beta_mean_Short(i_Short + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Short = i_Short + 1;
    end
end

delete_data_Short = delete_data_Short + length(deleted_idx_Short);
% disp('Short被刪掉的列的索引(alpha第四run):');
% disp(length(deleted_idx_Short));

big_than_2_5_Short = find(alpha_mean_Short > 2.5);
alpha_mean_Short(big_than_2_5_Short) = [];
beta_mean_Short(big_than_2_5_Short) = [];
big_than_2_5_Short = length(big_than_2_5_Short);
delete_data_Short = delete_data_Short + big_than_2_5_Short;

big_than_2_5_Short = find(beta_mean_Short > 2.5);
beta_mean_Short(big_than_2_5_Short) = [];
alpha_mean_Short(big_than_2_5_Short) = [];
big_than_2_5_Short = length(big_than_2_5_Short);
delete_data_Short = delete_data_Short + big_than_2_5_Short;



delete_data_Short = delete_data_Short + length(deleted_idx_Short);
fprintf('Short被刪除資料點數量：');
disp(delete_data_Short);

beta_mean_Short = movmean(beta_mean_Short, 3);
alpha_mean_Short = movmean(alpha_mean_Short,3);

% fprintf('Short剩餘資料點數量：');
% disp(length(beta_mean_Short));
% 
% 繪製調整後的折線圖Beta波
time_for_s = 1:length(beta_mean_Short);
figure;
subplot(2,1,1);
plot(time_for_s, beta_mean_Short, 'LineWidth', 2);
title('Short 12~28Hz平均功率(去除體動)(標準化)');
xlabel('Time (seconds)');
ylim([-1 5]);
xlim([0 length(time_for_s)]);  % 秒數區段
xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
ylabel('平均功率');
grid on;


% 繪製調整後的折線圖Alpha波
time_for_s = 1:length(alpha_mean_Short);
subplot(2,1,2);
plot(time_for_s, alpha_mean_Short, 'LineWidth', 2);
title('Short 8~12Hz平均功率(去除體動)(標準化)');
xlabel('Time (seconds)');
ylim([-1 5]);
xlim([0 length(time_for_s)]);  % 秒數區段
xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
ylabel('平均功率');
grid on;

% beta_mean_mean_mean_Short = mean(beta_mean_Short(55:end));
% 
% alpha_mean_mean_mean_Short = mean(alpha_mean_Short(55:end));
% alpha_mean_mean_mean_Short = mean(alpha_mean_Short(55:end));

run('/Users/hoyi/Documents/Bloody.m');
run('/Users/hoyi/Documents/Wardrobe.m')
run('/Users/hoyi/Documents/Dont.m');
run('/Users/hoyi/Documents/Dro.m');
run('/Users/hoyi/Documents/Mr.m')

total_data = total_data_Bloody + total_data_Short + total_data_Dont + total_data_Dro + total_data_Wardrobe + total_data_Mr;
fprintf('最初所有資料點數量：');
disp(total_data);
% 所有data
beta_mean = [beta_mean_Wardrobe(54:400)];
alpha_mean = [alpha_mean_Wardrobe(54:400)];
combined_data = [beta_mean', alpha_mean'];

fprintf('剩餘資料點數量：');
disp(length(combined_data));
fprintf('被刪除資料點數量：');
disp(total_data - length(combined_data));

% k-means 
num_clusters = 3;  % 分成三群
[idx, C] = kmeans(combined_data, num_clusters, 'Replicates',20);

counts = histcounts(idx, num_clusters);

% 每個群的點數量
for i = 1:num_clusters
    fprintf('Cluster %d (顏色 %s) 的點數量: %d\n', i, getColor(i), counts(i));
end

% 計算每群的 Alpha 和 Beta 波的平均值
for i = 1:num_clusters
    group_beta_mean = mean(beta_mean(idx == i));
    group_alpha_mean = mean(alpha_mean(idx == i));
    fprintf('Cluster %d (顏色 %s) 的 Beta 波平均值: %.4f\n', i, getColor(i), group_beta_mean);
    fprintf('Cluster %d (顏色 %s) 的 Alpha 波平均值: %.4f\n', i, getColor(i), group_alpha_mean);
end

figure;
gscatter(beta_mean, alpha_mean, idx, 'brg', '.', 8);  % 使用三種顏色，藍色、紅色和綠色
hold on;

% 繪製 alpha = beta 的直線
xl = xlim;  % 獲取當前 x 軸的範圍
plot(xl, xl, '--k', 'LineWidth', 1.5);  % 繪製直線，使用黑色虛線

% 繪製聚類質心
scatter(C(:, 1), C(:, 2), 100, 'kx', 'LineWidth', 2); 
title('K-means ');
xlabel('Beta');
ylabel('Alpha');

xlim([-0.8, 2]);
ylim([-0.8, 2]);
xticks(-0.6:0.1:2);
yticks(-0.6:0.1:2); 
grid on;

% 更新圖例
legend('群組 1', '群組 2', '群組 3', 'Centroids', 'alpha = beta');
legend('Location', 'northeastoutside');

hold off;

% 颜色函数定义
function color = getColor(clusterIndex)
    colors = {'blue', 'red', 'green'};
    color = colors{clusterIndex};
end
