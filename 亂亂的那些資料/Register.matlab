
% %平均功率折線圖
% % 選擇頻率範圍在12到28Hz
% freq_idx = (cz_f >= 12) & (cz_f <= 28);
% cz_selected_freq = cz_f(freq_idx);
% cz_selected_power = cz_p(freq_idx, :);
% 
% % 計算平均功率
% cz_avg_power = mean(cz_selected_power, 1);
% % 找到超過3的點的索引
% exceed_idx = find(cz_avg_power > 0.6);
% 
% % 替換每個超過0.6的點
% for i = 1:length(exceed_idx)
%     idx = exceed_idx(i);
%     if idx == 1  % 第一个点，只能用后一个点的值
%         next_idx = idx + 1;
%         while next_idx <= length(cz_avg_power) && cz_avg_power(next_idx) > 0.6
%             next_idx = next_idx + 1;
%         end
%         if next_idx <= length(cz_avg_power)
%             cz_avg_power(idx) = cz_avg_power(next_idx);
%         end
%     elseif idx == length(cz_avg_power)  % 最后一个点，只能用前一个点的值
%         prev_idx = idx - 1;
%         while prev_idx >= 1 && cz_avg_power(prev_idx) > 0.6
%             prev_idx = prev_idx - 1;
%         end
%         if prev_idx >= 1
%             cz_avg_power(idx) = cz_avg_power(prev_idx);
%         end
%     else  % 中间的点，尝试用前一个点和后一个点的均值替换
%         prev_idx = idx - 1;
%         next_idx = idx + 1;
%         while prev_idx >= 1 && cz_avg_power(prev_idx) > 0.6
%             prev_idx = prev_idx - 1;
%         end
%         while next_idx <= length(cz_avg_power) && cz_avg_power(next_idx) > 0.6
%             next_idx = next_idx + 1;
%         end
%         if prev_idx >= 1 && next_idx <= length(cz_avg_power)
%             cz_avg_power(idx) = mean([cz_avg_power(prev_idx), cz_avg_power(next_idx)]);
%         elseif prev_idx >= 1
%             cz_avg_power(idx) = cz_avg_power(prev_idx);
%         elseif next_idx <= length(cz_avg_power)
%             cz_avg_power(idx) = cz_avg_power(next_idx);
%         end
%     end
% end
% 
% 
% % 繪製折線圖Beta波
% figure;
% plot(cz_t, cz_avg_power, 'LineWidth', 2);
% title('12-28Hz平均功率');
% xlabel('Time (seconds)');
% ylabel('平均功率');
% grid on;
% xlim([0 60]);
% xticks(0:10:60) ;
% ylim([0 0.8]);
% yticks(0:0.05:0.8) 
% 
% % 選擇頻率範圍在8到12Hz
% freq_idx1 = (cz_f >= 8) & (cz_f <= 12);
% cz_selected_freq1 = cz_f(freq_idx1);
% cz_selected_power1 = cz_p(freq_idx1, :);
% % 計算平均功率
% cz_avg_power1 = mean(cz_selected_power1, 1);
% % 找到超過3的點的索引
% exceed_idx1 = find(cz_avg_power1 > 3);
% 
% % 替换每个超过3的点
% for i = 1:length(exceed_idx1)
%     idx = exceed_idx1(i);
%     if idx == 1  % 第一个点，只能用后一个点的值
%         next_idx = idx + 1;
%         while next_idx <= length(cz_avg_power1) && cz_avg_power1(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if next_idx <= length(cz_avg_power1)
%             cz_avg_power1(idx) = cz_avg_power1(next_idx);
%         end
%     elseif idx == length(cz_avg_power1)  % 最后一个点，只能用前一个点的值
%         prev_idx = idx - 1;
%         while prev_idx >= 1 && cz_avg_power1(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         if prev_idx >= 1
%             cz_avg_power1(idx) = cz_avg_power1(prev_idx);
%         end
%     else  % 中间的点，尝试用前一个点和后一个点的均值替换
%         prev_idx = idx - 1;
%         next_idx = idx + 1;
%         while prev_idx >= 1 && cz_avg_power1(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         while next_idx <= length(cz_avg_power1) && cz_avg_power1(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if prev_idx >= 1 && next_idx <= length(cz_avg_power1)
%             cz_avg_power1(idx) = mean([cz_avg_power1(prev_idx), cz_avg_power1(next_idx)]);
%         elseif prev_idx >= 1
%             cz_avg_power1(idx) = cz_avg_power1(prev_idx);
%         elseif next_idx <= length(cz_avg_power1)
%             cz_avg_power1(idx) = cz_avg_power1(next_idx);
%         end
%     end
% end
% 
% 
% % 繪製折線圖Alpha波
% figure;
% plot(cz_t, cz_avg_power1, 'LineWidth', 2);
% title('8-12Hz平均功率');
% xlabel('Time (seconds)');
% ylabel('平均功率');
% grid on;
% xlim([0 60]);
% xticks(0:10:60) ;
% ylim([0 3]);
% yticks(0:0.5:3) 
% 
% 
% % 選擇頻率範圍在12到28Hz
% freq_idx = (cz_f >= 8) & (cz_f <= 12);
% cz_selected_freq = cz_f(freq_idx);
% cz_selected_power = cz_p(freq_idx, :);
% 
% % 計算10到60秒的平均功率
% time_idx_10_60 = (cz_t >= 10) & (cz_t <= 60);
% avg_power_10_60 = mean(cz_selected_power(:, time_idx_10_60), 2);
% 
% % 找到超過3的點的索引
% exceed_idx = find(avg_power_10_60 > 3);
% 
% % 替換每個超過3的點
% for i = 1:length(exceed_idx)
%     idx = exceed_idx(i);
%     if idx == 1  % 第一个点，只能用后一个点的值
%         next_idx = idx + 1;
%         while next_idx <= length(avg_power_10_60) && avg_power_10_60(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if next_idx <= length(avg_power_10_60)
%             avg_power_10_60(idx) = avg_power_10_60(next_idx);
%         end
%     elseif idx == length(avg_power_10_60)  % 最后一个点，只能用前一个点的值
%         prev_idx = idx - 1;
%         while prev_idx >= 1 && avg_power_10_60(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         if prev_idx >= 1
%             avg_power_10_60(idx) = avg_power_10_60(prev_idx);
%         end
%     else  % 中间的点，尝试用前一个点和后一个点的均值替换
%         prev_idx = idx - 1;
%         next_idx = idx + 1;
%         while prev_idx >= 1 && avg_power_10_60(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         while next_idx <= length(avg_power_10_60) && avg_power_10_60(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if prev_idx >= 1 && next_idx <= length(avg_power_10_60)
%             avg_power_10_60(idx) = mean([avg_power_10_60(prev_idx), avg_power_10_60(next_idx)]);
%         elseif prev_idx >= 1
%             avg_power_10_60(idx) = avg_power_10_60(prev_idx);
%         elseif next_idx <= length(avg_power_10_60)
%             avg_power_10_60(idx) = avg_power_10_60(next_idx);
%         end
%     end
% end
% 
% avg_power_10_60 = mean(avg_power_10_60);
% disp(avg_power_10_60);
% % 計算100到150秒的平均功率
% time_idx_100_150 = (cz_t >= 60) & (cz_t <= 155);
% avg_power_100_150 = mean(cz_selected_power(:, time_idx_100_150), 2);
% 
% % 找到超過3的點的索引
% exceed_idx1 = find(avg_power_100_150 > 3);
% 
% % 替換每個超過3的點
% for i = 1:length(exceed_idx1)
%     idx = exceed_idx1(i);
%     if idx == 1  % 第一个点，只能用后一个点的值
%         next_idx = idx + 1;
%         while next_idx <= length(avg_power_100_150) && avg_power_100_150(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if next_idx <= length(avg_power_100_150)
%             avg_power_100_150(idx) = avg_power_100_150(next_idx);
%         end
%     elseif idx == length(avg_power_100_150)  % 最后一个点，只能用前一个点的值
%         prev_idx = idx - 1;
%         while prev_idx >= 1 && avg_power_100_150(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         if prev_idx >= 1
%             avg_power_100_150(idx) = avg_power_100_150(prev_idx);
%         end
%     else  % 中间的点，尝试用前一个点和后一个点的均值替换
%         prev_idx = idx - 1;
%         next_idx = idx + 1;
%         while prev_idx >= 1 && avg_power_100_150(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         while next_idx <= length(avg_power_100_150) && avg_power_100_150(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if prev_idx >= 1 && next_idx <= length(avg_power_100_150)
%             avg_power_100_150(idx) = mean([avg_power_100_150(prev_idx), avg_power_100_150(next_idx)]);
%         elseif prev_idx >= 1
%             avg_power_100_150(idx) = avg_power_100_150(prev_idx);
%         elseif next_idx <= length(avg_power_100_150)
%             avg_power_100_150(idx) = avg_power_100_150(next_idx);
%         end
%     end
% end
% 
% avg_power_100_150 = mean(avg_power_100_150);
% 
% % 計算相對變化值
% relative_change =abs(avg_power_100_150 - avg_power_10_60) / avg_power_10_60 ;
% fprintf('avg_power_10_60: %.5f\n', avg_power_10_60);
% fprintf('avg_power_100_150: %.5f\n', avg_power_100_150);
% 
% % 打印相對變化值
% fprintf('10-60s與100-150s變化值: %.5f\n', relative_change);
% 
% % 繪製10~60秒和100~150秒的平均功率柱状圖
% figure;
% bar([avg_power_10_60, avg_power_100_150]);
% title('不同時間段的平均功率');
% xlabel('時間段');
% ylabel('平均功率');
% set(gca, 'XTickLabel', {'0-60s', '60-155s'});
% ylim([0 1]);
% yticks(0:0.1:1) 
% grid on;
% %----------------------------------------------------------------------------------%
% % 選擇頻率範圍在12到28Hz
% freq_idx = (cz_f >= 8) & (cz_f <= 12);
% cz_selected_freq = cz_f(freq_idx);
% cz_selected_power = cz_p(freq_idx, :);
% 
% % 計算230到280秒的平均功率
% time_idx_230_280 = (cz_t >= 230) & (cz_t <= 280);
% avg_power_230_280 = mean(cz_selected_power(:, time_idx_230_280), 2);
% 
% % 找到超過3的點的索引
% exceed_idx2 = find(avg_power_230_280 > 3);
% 
% % 替換每個超過3的點
% for i = 1:length(exceed_idx2)
%     idx = exceed_idx2(i);
%     if idx == 1  % 第一个点，只能用后一个点的值
%         next_idx = idx + 1;
%         while next_idx <= length(avg_power_230_280) && avg_power_230_280(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if next_idx <= length(avg_power_230_280)
%             avg_power_230_280(idx) = avg_power_230_280(next_idx);
%         end
%     elseif idx == length(avg_power_230_280)  % 最后一个点，只能用前一个点的值
%         prev_idx = idx - 1;
%         while prev_idx >= 1 && avg_power_230_280(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         if prev_idx >= 1
%             avg_power_230_280(idx) = avg_power_230_280(prev_idx);
%         end
%     else  % 中间的点，尝试用前一个点和后一个点的均值替换
%         prev_idx = idx - 1;
%         next_idx = idx + 1;
%         while prev_idx >= 1 && avg_power_230_280(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         while next_idx <= length(avg_power_230_280) && avg_power_230_280(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if prev_idx >= 1 && next_idx <= length(avg_power_230_280)
%             avg_power_230_280(idx) = mean([avg_power_230_280(prev_idx), avg_power_230_280(next_idx)]);
%         elseif prev_idx >= 1
%             avg_power_230_280(idx) = avg_power_230_280(prev_idx);
%         elseif next_idx <= length(avg_power_230_280)
%             avg_power_230_280(idx) = avg_power_230_280(next_idx);
%         end
%     end
% end
% avg_power_230_280 = mean(avg_power_230_280);
% 
% % 計算相對變化值
% relative_change1 = abs(avg_power_230_280 - avg_power_10_60) /avg_power_10_60 ;
% fprintf('avg_power_10_60: %.5f\n', avg_power_10_60);
% fprintf('avg_power_230_280: %.5f\n', avg_power_230_280);
% 
% % 打印相對變化值
% fprintf('10-60s與230-280s變化值: %.5f\n', relative_change1);
% 
% % 繪製10~60秒和230~280秒的平均功率柱状圖
% figure;
% bar([avg_power_10_60, avg_power_230_280]);
% title('不同時間段的平均功率');
% ylim([0 1]);
% yticks(0:0.1:1) 
% xlabel('時間段');
% ylabel('平均功率');
% set(gca, 'XTickLabel', {'0-60s', '230-280s'});
% 
% grid on;
% 
% 
% % 設置頻率範圍
% freq_range = (cz_f >= 8) & (cz_f <= 12);
% 
% % 計算基準時間段（0-60s）的平均功率
% time_idx_base = (cz_t >= 0) & (cz_t <= 60);
% base_power = (mean(cz_p(freq_range, time_idx_base), 1));
% 
% % 找到超過3的點的索引
% exceed_idx3 = find(base_power > 3);
% 
% % 替換每個超過3的點
% for i = 1:length(exceed_idx3)
%     idx = exceed_idx3(i);
%     if idx == 1  % 第一个点，只能用后一个点的值
%         next_idx = idx + 1;
%         while next_idx <= length(base_power) && base_power(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if next_idx <= length(base_power)
%             base_power(idx) = base_power(next_idx);
%         end
%     elseif idx == length(base_power)  % 最后一个点，只能用前一个点的值
%         prev_idx = idx - 1;
%         while prev_idx >= 1 && base_power(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         if prev_idx >= 1
%             base_power(idx) = base_power(prev_idx);
%         end
%     else  % 中间的点，尝试用前一个点和后一个点的均值替换
%         prev_idx = idx - 1;
%         next_idx = idx + 1;
%         while prev_idx >= 1 && base_power(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         while next_idx <= length(base_power) && base_power(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if prev_idx >= 1 && next_idx <= length(base_power)
%             base_power(idx) = mean([base_power(prev_idx), base_power(next_idx)]);
%         elseif prev_idx >= 1
%             base_power(idx) = base_power(prev_idx);
%         elseif next_idx <= length(base_power)
%             base_power(idx) = base_power(next_idx);
%         end
%     end
% end
% 
% base_power = mean(base_power);
% % 計算60-155s的平均功率
% time_idx_60_155 = (cz_t >= 60) & (cz_t <= 155);
% power_60_155 = mean(cz_p(freq_range, time_idx_60_155), 1);
% % 找到超過3的點的索引
% exceed_idx = find(power_60_155 > 3);
% 
% % 替換每個超過3的點
% for i = 1:length(exceed_idx)
%     idx = exceed_idx(i);
%     if idx == 1  % 第一个点，只能用后一个点的值
%         next_idx = idx + 1;
%         while next_idx <= length(power_60_155) && power_60_155(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if next_idx <= length(power_60_155)
%             power_60_155(idx) = power_60_155(next_idx);
%         end
%     elseif idx == length(power_60_155)  % 最后一个点，只能用前一个点的值
%         prev_idx = idx - 1;
%         while prev_idx >= 1 && power_60_155(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         if prev_idx >= 1
%             power_60_155(idx) = power_60_155(prev_idx);
%         end
%     else  % 中间的点，尝试用前一个点和后一个点的均值替换
%         prev_idx = idx - 1;
%         next_idx = idx + 1;
%         while prev_idx >= 1 && power_60_155(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         while next_idx <= length(power_60_155) && power_60_155(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if prev_idx >= 1 && next_idx <= length(power_60_155)
%             power_60_155(idx) = mean([power_60_155(prev_idx), power_60_155(next_idx)]);
%         elseif prev_idx >= 1
%             power_60_155(idx) = power_60_155(prev_idx);
%         elseif next_idx <= length(power_60_155)
%             power_60_155(idx) = power_60_155(next_idx);
%         end
%     end
% end
% % 計算230-280s的平均功率
% time_idx_230_280 = (cz_t >= 230) & (cz_t <= 280);
% power_230_280 = mean(cz_p(freq_range, time_idx_230_280), 1);
% 
% % 找到超過3的點的索引
% exceed_idx1 = find(power_230_280 > 3);
% 
% % 替換每個超過3的點
% for i = 1:length(exceed_idx1)
%     idx = exceed_idx1(i);
%     if idx == 1  % 第一个点，只能用后一个点的值
%         next_idx = idx + 1;
%         while next_idx <= length(power_230_280) && power_230_280(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if next_idx <= length(power_230_280)
%             power_230_280(idx) = power_230_280(next_idx);
%         end
%     elseif idx == length(power_230_280)  % 最后一个点，只能用前一个点的值
%         prev_idx = idx - 1;
%         while prev_idx >= 1 && power_230_280(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         if prev_idx >= 1
%             power_230_280(idx) = power_230_280(prev_idx);
%         end
%     else  % 中间的点，尝试用前一个点和后一个点的均值替换
%         prev_idx = idx - 1;
%         next_idx = idx + 1;
%         while prev_idx >= 1 && power_230_280(prev_idx) > 3
%             prev_idx = prev_idx - 1;
%         end
%         while next_idx <= length(power_230_280) && power_230_280(next_idx) > 3
%             next_idx = next_idx + 1;
%         end
%         if prev_idx >= 1 && next_idx <= length(power_230_280)
%             power_230_280(idx) = mean([power_230_280(prev_idx), power_230_280(next_idx)]);
%         elseif prev_idx >= 1
%             power_230_280(idx) = power_230_280(prev_idx);
%         elseif next_idx <= length(power_230_280)
%             power_230_280(idx) = power_230_280(next_idx);
%         end
%     end
% end
% % 計算相對變化值
% relative_power_60_155 = abs(power_60_155 - base_power) /base_power ;
% relative_power_230_280 = abs(power_230_280 - base_power) / base_power;
% 
% % 繪製60-155s與0-60s的平均功率變化
% figure;
% plot(cz_t(time_idx_60_155), relative_power_60_155, 'LineWidth', 2);
% title('60-155s與0-60s平均功率變化');
% xlabel('Time (seconds)');
% ylabel('相對變化的平均功率');
% grid on;
% xlim([60 155]);
% ylim([min(relative_power_60_155)-0.1, max(relative_power_60_155)+0.1]);
% 
% % 繪製230-280s與0-60s的平均功率變化
% figure;
% plot(cz_t(time_idx_230_280), relative_power_230_280, 'LineWidth', 2);
% title('230-280s與0-60s平均功率變化');
% xlabel('Time (seconds)');
% ylabel('相對變化的平均功率');
% grid on;
% xlim([230 280]);
% ylim([min(relative_power_230_280)-0.1, max(relative_power_230_280)+0.1]);



% 計算 cz_s_twice_mean_adjusted 的增長率
growth_rate = abs(cz_s_twice_mean_adjusted_new(2:end) ./ cz_s_twice_mean_adjusted_new(1:end-1));

time_for_s = 1:length(growth_rate);
fprintf('還沒去除體動資料點數量：');
disp(length(growth_rate));
% 功率增長率折線圖
figure;
plot(time_for_s,growth_rate, 'LineWidth', 2);
title('Beta增長率折線圖 還沒去體動');
xlabel('Time (seconds)');
ylim([0 10]);
ylabel('平均功率');
grid on;


% % 繪製盒狀圖
% % figure;
% % boxplot(growth_rate);
% % title('增長率盒壯圖 還沒去體動');
% % ylabel('分佈');
% % xlabel('能量大小');
% % 
% % 使用isoutlier來識別離群值
% % outliers = isoutlier(growth_rate);
% % 繪製cz_s_twice_mean的折線圖
% % figure;
% % plot(time_for_s, growth_rate, '-b', 'LineWidth', 1.5); % 藍色線條
% % 
% % hold on;
% % 
% % 將離群值用紅色圓點標示出來
% % plot(time_for_s(outliers),growth_rate(outliers), 'ro', 'MarkerSize', 8);
% % 
% % title('增長率折線圖 還沒去體動');
% % xlabel('時間 (秒)');
% % ylabel('cz\_s\_twice\_mean 值');
% % legend('cz\_s\_twice\_mean', '離群值');
% % 
% % hold off;
% % 
% % 計算第一四分位數和第三四分位數
% % Q1 = prctile(growth_rate, 25);
% % Q3 = prctile(growth_rate, 75);
% % IQR = Q3 - Q1;
% % 
% % 計算盒鬚的最大值
% % whisker_max = Q3 + 1.5 * IQR;
% % 
% % 設置新的閾值為盒鬚最大值的兩倍
% % threshold = 0.5* whisker_max;
% % 
% % 找到超過閾值的索引
% % idx = find(growth_rate > threshold);
% % 
% % 初始化一個變數來存儲被刪掉的列的索引
% % deleted_indices = [];
% % 
% % 檢查每個索引的下一列是否存在，如果存在則將其索引保存到 deleted_indices，並從 growth_rate 中刪除
% % for i = 1:length(idx)
% %     if idx(i) < length(growth_rate) % 確保不會超過範圍
% %         將被刪掉的列的索引存儲在 deleted_indices
% %         deleted_indices(end + 1) = idx(i) + 1;
% %     end
% % end
% % 
% % 顯示結果
% % disp('處理後的growth_rate:');
% % disp(growth_rate);
% % 
% % disp('被刪掉的列的索引:');
% % disp(deleted_indices);
% % 
% % 重新計算 time_for_s
% % time_for_s = 1:length(growth_rate);
% % 
% % 繪製折線圖，標示出新的離群值
% % figure;
% % plot(time_for_s, growth_rate, '-b', 'LineWidth', 1.5); % 藍色線條
% % 
% % hold on;
% % 
% % 使用isoutlier來識別新一輪的離群值
% % outliers = isoutlier(growth_rate);
% % 
% % 將離群值用紅色圓點標示出來
% % plot(time_for_s(outliers),growth_rate(outliers), 'ro', 'MarkerSize', 8);
% % 
% % title('增長率折線圖 已經去除體動');
% % xlabel('時間 (秒)');
% % ylabel('cz\_s\_twice\_mean 值');
% % legend('cz\_s\_twice\_mean', '離群值');
% % hold off;
% % 
% % 
% % 將 num_of_threshold 陣列中的行從 cz_s_twice_mean_adjusted 中刪除
% % cz_s_twice_mean_adjusted(deleted_indices) = [];
% % 
% % fprintf('已經去除體動資料點數量：');
% % disp(length(cz_s_twice_mean_adjusted))
% % % 顯示刪除後的 cz_s_twice_mean_adjusted
% % disp('刪除後的 cz_s_twice_mean_adjusted:');
% % disp(cz_s_twice_mean_adjusted);
% % 
% % 重新計算 time_for_s
% % time_for_s = 1:length(cz_s_twice_mean_adjusted);
% % 
% % 繪製折線圖
% % figure;
% % plot(time_for_s, cz_s_twice_mean_adjusted, '-b', 'LineWidth', 1.5); % 藍色線條
% % title('cz\_s\_twice\_mean\_adjusted (刪除閾值列後)');
% % xlabel('時間 (秒)');
% % ylabel('cz\_s\_twice\_mean\_adjusted 值');
% % grid on;
% % 

