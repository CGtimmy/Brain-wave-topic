
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








data = load('/Users/hoyi/Desktop/rrr/mat檔/Rawdatafile_20240813221410_bleEXGdata__Short.mat');
data = data.data;
data = data';
% 提取CZ和FZ data(通道一 通道二）
cz_signal = data(:, 3); 
fz_signal = data(:, 1);
fs = 250;
window = hamming(250);
noverlap = 125; 
nfft = 256; 
total_time = length(cz_signal) / fs -1;
total_time1 = round(total_time);
tCZ = (0:length(cz_signal)-1) / fs;
tFZ = (0:length(fz_signal)-1) / fs;
fprintf('整段時間: %.f 秒\n', total_time);
fprintf('data長度: %.f\n', size(cz_signal));

% 計算CZ信號的STFT
[cz_s, cz_f, cz_t, cz_p] = spectrogram(cz_signal, window, noverlap, nfft, fs,'Power');
% 計算FZ信號的STFT
[fz_s, fz_f, fz_t, fz_p] = spectrogram(fz_signal, window, noverlap, nfft, fs,'Power');

% % CZ矩陣大小
% [m, n] = size(cz_s);
% fprintf('cz_s 矩陣大小 %d x %d\n', m, n);

% % 顯示前10row和前10column
% disp(cz_s(1:2, 1:2));
% disp(cz_p(1:2, 1:2));
start_time = 0;
end_time = total_time;

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

% beta_freg_idx = (cz_f >= 12) & (cz_f <= 28);
% 
% beta_cz_s_abs = abs(cz_s);
% beta_selected_power = beta_cz_s_abs(beta_freg_idx, :);
% beta_mean = mean(beta_selected_power,1);
% 
% %Alpha波
% freq_idx_alpha = (cz_f >= 8) & (cz_f <= 12);
% alpha_power = abs(cz_s);
% alpha_selected_power = alpha_power(freq_idx_alpha, :);
% alpha_mean = mean(alpha_power,1);
% 
% % 總點數
% total_points = length(beta_mean);
% fprintf('總點數: %d\n', total_points);
% 
% % 如果beta_mean的長度是奇數，刪除最後一個元素
% if mod(length(beta_mean), 2) ~= 0
%     beta_mean(end) = [];
%     alpha_mean(end) = [];
% end
% 
% % 將beta_mean中的每兩列數值平均
% beta_mean = mean(reshape(beta_mean, 2, []), 1);
% fprintf('beta_mean: %d\n', length(beta_mean));
% 
% %alpha
% alpha_mean = mean(reshape(alpha_mean, 2, []), 1);
% 
% % 獨立出前58列並存成新變數
% beta_mean_baseline = beta_mean(1:60);
% 
% % % 繪製盒狀圖
% % figure;
% % boxplot(beta_mean_baseline);
% % title('12-28 Hz 1~58s');
% % ylabel('分佈');
% % xlabel('能量大小');
% alpha_mean_1_58 = alpha_mean(1:60);
% % 使用isoutlier來識別離群值
% outliers = isoutlier(beta_mean_baseline);
% outliers1 = isoutlier(alpha_mean_1_58);
% 
% % 将 outliers1 中为 1 的位置替换到 outliers 中
% outliers(outliers1 == 1) = 1;
% 
% 
% 
% % 離群值的數量
% num_outliers = sum(outliers);
% fprintf('離群值的數量: %d\n', num_outliers);
% 
% % 離群值在矩陣中的位置
% outlier_positions = find(outliers);
% fprintf('離群值的位置: ');
% disp(outlier_positions);
% 
% beta_mean_baseline(outlier_positions) = [];
% beta_mean(outlier_positions) = [];
% % disp(beta_mean_baseline);
% 
% %Alpha
% alpha_mean(outlier_positions)=[];
% alpha_mean_1_58(outlier_positions) = [];
% alpha_mean_mean_1_58 = mean(alpha_mean_1_58);
% 
% beta_mean(1:length(beta_mean_baseline)) = beta_mean_baseline; %覆蓋  %%%???為何不直接
% 
% % time_for_s = 0:length(beta_mean_baseline)-1;
% % 
% % % %% 繪製折線圖Beta波 1~58s
% % figure;
% % plot(time_for_s,beta_mean_baseline, 'LineWidth', 2);
% % title('12-28Hz平均功率(已去除超過100的點)1~58s');
% % xlabel('Time (seconds)');
% % ylim([0 100]);
% % ylabel('平均功率');
% % grid on;
% 
% beta_mean_mean_baseline = mean(beta_mean_baseline);
% 
% 
% % 將 beta_mean 的每一列減去 beta_mean_mean_baseline
% beta_mean = beta_mean - beta_mean_mean_baseline;
% beta_mean = beta_mean / beta_mean_mean_baseline;
% 
% %Alpha
% alpha_mean = alpha_mean - alpha_mean_mean_1_58;
% alpha_mean = alpha_mean / alpha_mean_mean_1_58;
% 
% %%%平移！！！
% beta_mean_offset = beta_mean;
% % 找到最小值
% min_value = min(beta_mean);
% % 計算偏移量
% if min_value < 0
%     offset = abs(min_value);
% else
%     offset = 0;
% end
% 
% % 平移數值
% beta_mean_offset = beta_mean_offset + offset + 0.1;
% time_for_s = 1:length(beta_mean_offset);
% 
% 
% 
% % 计算中位数
% median_value = median(beta_mean_offset);
% 
% % 找到小于中位数的点并将其替换为中位数
% beta_mean_offset(beta_mean_offset < median_value) = median_value;
% 
% 
% 
% % 初始化一個變數來存儲被刪掉的列的索引
% deleted_indices = [];
% 
% % 遍歷 beta_mean_offset，檢查是否下一列的值是目前列的值的5倍
% i = 1;
% while i < length(beta_mean_offset)
%     if beta_mean_offset(i + 1) >= 2 * beta_mean_offset(i)
%         % 如果條件滿足，記錄被刪除的列的索引
%         deleted_indices(end + 1) = i + 1;
%         % 刪除下一列
%         fprintf('當前的值');
%         disp(beta_mean_offset(i));
%         fprintf('被刪的值');
%         disp(beta_mean_offset(i + 1));
%         beta_mean_offset(i + 1) = [];
%         beta_mean(i + 1) = [];
%         alpha_mean(i + 1) = [];
%         % 不移動i, 以便重新檢查新的下一列
%     else
%         % 只有當沒有刪除列時，才移動到下一個元素
%         i = i + 1;
%     end
% end
% 
% % 顯示被刪掉的列的索引
% disp('被刪掉的列的索引:');
% disp(deleted_indices);
% 
% % 繪製調整後的折線圖Beta波
% time_for_s = 1:length(beta_mean);
% figure;
% plot(time_for_s, beta_mean, 'LineWidth', 2);
% title('12~28Hz平均功率(去除體動)(標準化)');
% xlabel('Time (seconds)');
% ylim([-1 3]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;
% 
% % 繪製調整後的折線圖Alpha波
% time_for_s = 1:length(alpha_mean);
% figure;
% plot(time_for_s, alpha_mean, 'LineWidth', 2);
% title('8~12Hz平均功率(去除體動)(標準化)');
% xlabel('Time (seconds)');
% ylim([-1 3]);
% xlim([0 length(time_for_s)]);  % 秒數區段
% xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% ylabel('平均功率');
% grid on;
% 
% beta_mean_baseline = (beta_mean_baseline-beta_mean_mean_baseline) / beta_mean_mean_baseline;
% 
% 
% % 将 beta_mean 和 alpha_mean 组合成一个矩阵
% combined_data = [beta_mean', alpha_mean'];
% 
% % 使用 k-means 进行聚类
% num_clusters = 3;  % 设置为三群
% [idx, C] = kmeans(combined_data, num_clusters);
% 
% % % 显示聚类结果
% % fprintf('聚类索引:\n');
% % disp(idx);
% 
% % 绘制聚类结果的散点图
% figure;
% scatter(beta_mean, alpha_mean, 50, idx, 'filled');
% title('K-means 聚类结果');
% xlabel('Beta 波能量');
% ylabel('Alpha 波能量');



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
fprintf('Short整段時間: %.f 秒\n', total_time_Short);
fprintf('Short的data長度: %.f\n', size(cz_signal_Short));

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

fprintf("Short每秒資料點數量：");
disp(length(beta_mean_Short));


% 將Short前60列存成新變數
beta_mean_baseline_Short = beta_mean_Short(1:60);
alpha_mean_baseline_Short = alpha_mean_Short(1:60);

% 使用isoutlier來識別Short的baseline離群值
beta_outliers_baseline_Short = isoutlier(beta_mean_baseline_Short);
alpha_outliers_baseline_Short = isoutlier(alpha_mean_baseline_Short);

% 將alpha_outliers_baseline_Short中為1的位置替換到beta_outliers_baseline_Short中
beta_outliers_baseline_Short(alpha_outliers_baseline_Short == 1) = 1;
outliers_baseline_Short = beta_outliers_baseline_Short;

% Short的baseline離群值的數量
fprintf('Short的baseline離群值的數量: %d\n',sum(outliers_baseline_Short));

% Short的baseline離群值在矩陣中的位置
outliers_positions_baseline_Short = find(outliers_baseline_Short);
fprintf('離群值的位置: ');
disp(outliers_positions_baseline_Short);

%Short將1-60s離群值刪除
beta_mean_baseline_Short(outliers_positions_baseline_Short) = [];
beta_mean_Short(outliers_positions_baseline_Short) = [];

alpha_mean_baseline_Short(outliers_positions_baseline_Short) = [];
alpha_mean_Short(outliers_positions_baseline_Short)=[];

%Short的baseline的平均值
beta_mean_mean_baseline_Short = mean(beta_mean_baseline_Short);
alpha_mean_mean_baseline_Short = mean(alpha_mean_baseline_Short);


%Short標準化
beta_mean_Short = beta_mean_Short - beta_mean_mean_baseline_Short;
beta_mean_Short = beta_mean_Short / beta_mean_mean_baseline_Short;

alpha_mean_Short = alpha_mean_Short - alpha_mean_mean_baseline_Short;
alpha_mean_Short = alpha_mean_Short / alpha_mean_mean_baseline_Short;

%Short平移
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

disp('被刪掉的列的索引(Beta第一run):');
disp(deleted_idx_Short);
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

disp('被刪掉的列的索引(alpha第二run):');
disp(deleted_idx_Short);


% %% 繪製調整後的折線圖Beta波
% % time_for_s = 1:length(beta_mean_move_Short);
% % figure;
% % plot(time_for_s, beta_mean_move_Short, 'LineWidth', 2);
% % title('12~28Hz平均功率(去除體動)(標準化)');
% % xlabel('Time (seconds)');
% % ylim([-1 3]);
% % xlim([0 length(time_for_s)]);  % 秒數區段
% % xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% % ylabel('平均功率');
% % grid on;
% % 
% % 
% % %繪製調整後的折線圖Alpha波
% % time_for_s = 1:length(alpha_mean_move_Short);
% % figure;
% % plot(time_for_s, alpha_mean_move_Short, 'LineWidth', 2);
% % title('8~12Hz平均功率(去除體動)(標準化)');
% % xlabel('Time (seconds)');
% % ylim([-1 3]);
% % xlim([0 length(time_for_s)]);  % 秒數區段
% % xticks(0:10:length(time_for_s));  % 每幾秒顯示一個刻度
% % ylabel('平均功率');
% % grid on;


%第五次腦波數據(Bloody Mary Horror) 何翊 4CH+G CH1:CZ CH2:FZ
data_Bloody = load('/Users/hoyi/Desktop/rrr/mat檔/Rawdatafile_20240814123710_bleEXGdata_Bloody.mat');
data_Bloody = data_Bloody.data;
data_Bloody = data_Bloody';
cz_signal_Bloody = data_Bloody(:, 1); 
fs = 250;
window = hamming(250);
noverlap = 125; 
nfft = 256; 
total_time_Bloody = length(cz_signal_Bloody) / fs;
fprintf('Bloody整段時間: %.f 秒\n', total_time_Bloody);
fprintf('Bloody的data長度: %.f\n', size(cz_signal_Bloody));

% Bloody在Cz的STFT
[cz_s_Bloody, cz_f_Bloody, cz_t_Bloody, cz_p_Bloody] = spectrogram(cz_signal_Bloody, window, noverlap, nfft, fs,'Power');

start_time_Bloody = 0;
end_time_Bloody = total_time_Bloody;

% % Bloody在Cz的頻譜圖
% figure;
% subplot(2,1,1);
% surf(cz_t_Bloody, cz_f_Bloody, 10*log10(abs(cz_p_Bloody)), 'EdgeColor', 'none');
% axis tight;
% ylim([0 60]);
% xlim([start_time_Bloody end_time_Bloody])  %秒數區段
% xticks(start_time_Bloody:20:end_time_Bloody) %每幾秒顯示一個刻度
% view(0, 90);
% colorbar;
% title('CZ Spectrogram');
% xlabel('Time (sec)');
% ylabel('Frequency (Hz)');
% caxis([-10 20]);
% colormap(jet);

beta_freg_idx_Bloody = (cz_f_Bloody >= 12) & (cz_f_Bloody <= 28);
beta_cz_s_abs_Bloody = abs(cz_s_Bloody);
beta_selected_power_Bloody = beta_cz_s_abs_Bloody(beta_freg_idx_Bloody, :);
beta_mean_Bloody = mean(beta_selected_power_Bloody,1);

%Alpha波
alpha_freg_idx_Bloody = (cz_f_Bloody >= 8) & (cz_f_Bloody <= 12);
alpha_cz_s_abs_Bloody = abs(cz_s_Bloody);
alpha_selected_power_Bloody = alpha_cz_s_abs_Bloody(alpha_freg_idx_Bloody, :);
alpha_mean_Bloody = mean(alpha_selected_power_Bloody,1);

% 如果Bloody的長度是奇數，刪除最後5個元素，若是偶數，刪除最後4個元素
if mod(length(beta_mean_Bloody), 2) ~= 0
    beta_mean_Bloody(length(beta_mean_Bloody)-8:end) = [];
    alpha_mean_Bloody(length(alpha_mean_Bloody)-8:end) = [];
else 
    beta_mean_Bloody(length(beta_mean_Bloody)-7:end) = [];
    alpha_mean_Bloody(length(alpha_mean_Bloody)-7:end) = [];
end

% 將Bloody中的每兩列數值平均
beta_mean_Bloody = mean(reshape(beta_mean_Bloody, 2, []), 1);
alpha_mean_Bloody = mean(reshape(alpha_mean_Bloody, 2, []), 1);

fprintf("Bloody每秒資料點數量：");
disp(length(beta_mean_Bloody));


% 將Bloody前60列存成新變數
beta_mean_baseline_Bloody = beta_mean_Bloody(1:60);
alpha_mean_baseline_Bloody = alpha_mean_Bloody(1:60);

% 使用isoutlier來識別Bloody的baseline離群值
beta_outliers_baseline_Bloody = isoutlier(beta_mean_baseline_Bloody);
alpha_outliers_baseline_Bloody = isoutlier(alpha_mean_baseline_Bloody);

% 將alpha_outliers_baseline_Bloody中為1的位置替換到beta_outliers_baseline_Bloody中
beta_outliers_baseline_Bloody(alpha_outliers_baseline_Bloody == 1) = 1;
outliers_baseline_Bloody = beta_outliers_baseline_Bloody;

% Bloody的baseline離群值的數量
fprintf('Bloody的baseline離群值的數量: %d\n',sum(outliers_baseline_Bloody));

% Bloody的baseline離群值在矩陣中的位置
outliers_positions_baseline_Bloody = find(outliers_baseline_Bloody);
fprintf('Bloody離群值的位置: ');
disp(outliers_positions_baseline_Bloody);

%Bloody將1-60s離群值刪除
beta_mean_baseline_Bloody(outliers_positions_baseline_Bloody) = [];
beta_mean_Bloody(outliers_positions_baseline_Bloody) = [];

alpha_mean_baseline_Bloody(outliers_positions_baseline_Bloody) = [];
alpha_mean_Bloody(outliers_positions_baseline_Bloody)=[];

%Bloody的baseline的平均值
beta_mean_mean_baseline_Bloody = mean(beta_mean_baseline_Bloody);
alpha_mean_mean_baseline_Bloody = mean(alpha_mean_baseline_Bloody);


%Bloody標準化
beta_mean_Bloody = beta_mean_Bloody - beta_mean_mean_baseline_Bloody;
beta_mean_Bloody = beta_mean_Bloody / beta_mean_mean_baseline_Bloody;

alpha_mean_Bloody = alpha_mean_Bloody - alpha_mean_mean_baseline_Bloody;
alpha_mean_Bloody = alpha_mean_Bloody / alpha_mean_mean_baseline_Bloody;

%Bloody平移
%beta 
%找到最小值 計算偏移量 如果最小值比0小 將最小值平移至0.1 其他數值向上平移
beta_mean_move_Bloody = beta_mean_Bloody;
if min(beta_mean_Bloody) < 0
    beta_mean_offset_Bloody = abs(min(beta_mean_Bloody));
else
    beta_mean_offset_Bloody = 0;
end
beta_mean_move_Bloody = beta_mean_move_Bloody + beta_mean_offset_Bloody + 0.1;

%計算中位數 並將小於中位數的所有點替換為中位數
beta_mean_move_median_Bloody = median(beta_mean_move_Bloody);
beta_mean_move_Bloody(beta_mean_move_Bloody < beta_mean_move_median_Bloody) = beta_mean_move_median_Bloody;

%alpha
alpha_mean_move_Bloody = alpha_mean_Bloody;
if min(alpha_mean_Bloody) < 0
    alpha_mean_offset_Bloody = abs(min(alpha_mean_Bloody));
else
    alpha_mean_offset_Bloody = 0;
end
alpha_mean_move_Bloody = alpha_mean_move_Bloody + alpha_mean_offset_Bloody + 0.1;

alpha_mean_move_median_Bloody = median(alpha_mean_move_Bloody);
alpha_mean_move_Bloody(alpha_mean_move_Bloody < alpha_mean_move_median_Bloody) = alpha_mean_move_median_Bloody;


% 初始化一個變數來存儲被刪掉的列的索引
deleted_idx_Bloody = [];

% 遍歷 beta_mean_move_Bloody，檢查是否下一列的值是目前列的值的2倍
i_Bloody = 1;
while i_Bloody < length(beta_mean_move_Bloody)
    if beta_mean_move_Bloody(i_Bloody + 1) >= 2 * beta_mean_move_Bloody(i_Bloody)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Bloody(end + 1) = i_Bloody + 1;
        % 刪除下一列
        % fprintf('當前的值');
        % disp(beta_mean_move_Bloody(i_Bloody));
        % fprintf('被刪的值');
        % disp(beta_mean_move_Bloody(i_Bloody + 1));
        beta_mean_move_Bloody(i_Bloody + 1) = [];
        alpha_mean_move_Bloody(i_Bloody + 1) = [];
        beta_mean_Bloody(i_Bloody + 1) = [];
        alpha_mean_Bloody(i_Bloody + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Bloody = i_Bloody + 1;
    end
end

disp('Bloody被刪掉的列的索引(Beta第一run):');
disp(deleted_idx_Bloody);
deleted_idx_Bloody = [];

% 遍歷 alpha_mean_move_Bloody，檢查是否下一列的值是目前列的值的2倍
i_Bloody = 1;
while i_Bloody < length(alpha_mean_move_Bloody)
    if alpha_mean_move_Bloody(i_Bloody + 1) >= 2 * alpha_mean_move_Bloody(i_Bloody)
        % 如果條件滿足，記錄被刪除的列的索引
        deleted_idx_Bloody(end + 1) = i_Bloody + 1;
        % 刪除下一列
        % fprintf('當前的值');
        % disp(alpha_mean_move_Bloody(i_Bloody));
        % fprintf('被刪的值');
        % disp(alpha_mean_move_Bloody(i_Bloody + 1));
        alpha_mean_move_Bloody(i_Bloody + 1) = [];
        beta_mean_move_Bloody(i_Bloody + 1) = [];
        alpha_mean_Bloody(i_Bloody + 1) = [];
        beta_mean_Bloody(i_Bloody + 1) = [];
        % 不移動i, 以便重新檢查新的下一列
    else
        % 只有當沒有刪除列時，才移動到下一個元素
        i_Bloody = i_Bloody + 1;
    end
end

disp('Bloody被刪掉的列的索引(alpha第二run):');
disp(deleted_idx_Bloody);


%所有data
beta_mean = [beta_mean_Short,beta_mean_Bloody];
alpha_mean = [alpha_mean_Short, alpha_mean_Bloody];
combined_data = [beta_mean', alpha_mean'];
% Short k-means 
num_clusters = 3;  %
[idx, C] = kmeans(combined_data, num_clusters);

figure;
scatter(beta_mean, alpha_mean, 50, idx, 'filled');
title('K-means ');
xlabel('Beta');
ylabel('Alpha');

%所有data
beta_mean = [beta_mean_Short];
alpha_mean = [alpha_mean_Short];
combined_data = [beta_mean', alpha_mean'];
% k-means 
num_clusters = 3;  %
[idx, C] = kmeans(combined_data, num_clusters, 'Replicates', 20);


counts = histcounts(idx, num_clusters);

% 获取每个点在数据中的索引
indices = 1:length(beta_mean);

% 创建三维散点图
figure;
scatter3(beta_mean, alpha_mean, indices, 50, idx, 'filled'); % 使用scatter3绘制3D散点图

hold on;
plot3(C(:, 1), C(:, 2), mean(indices)*ones(size(C, 1), 1), 'kx', 'MarkerSize', 15, 'LineWidth', 3); % 绘制质心

title('K-means with Indices');
xlabel('Beta');
ylabel('Alpha');
zlabel('Index');

% 绘制图例
legend('baseline', 'fatigue', 'recovered', 'Centroids');
