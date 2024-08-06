
% 選擇頻率範圍在12到28Hz
freq_idx = (cz_f >= 12) & (cz_f <= 28);
cz_selected_freq = cz_f(freq_idx);
cz_selected_power = cz_p(freq_idx, :);

% 計算10到60秒的平均功率
time_idx_10_60 = (cz_t >= 10) & (cz_t <= 60);
avg_power_10_60 = mean(cz_selected_power(:, time_idx_10_60), 2);

% 找到超過0.6的點的索引
exceed_idx = find(avg_power_10_60 > 0.6);

% 替換每個超過0.6的點
for i = 1:length(exceed_idx)
    idx = exceed_idx(i);
    if idx == 1  % 第一個點，只能用後一個點的值
        avg_power_10_60(idx) = avg_power_10_60(idx + 1);
    elseif idx == length(avg_power_10_60)  % 最後一個點，只能用前一個點的值
        avg_power_10_60(idx) = avg_power_10_60(idx - 1);
    else
        avg_power_10_60(idx) = mean([avg_power_10_60(idx - 1), avg_power_10_60(idx + 1)]);
    end
end

avg_power_10_60 = mean(avg_power_10_60);

% 計算100到150秒的平均功率
time_idx_100_150 = (cz_t >= 100) & (cz_t <= 150);
avg_power_100_150 = mean(cz_selected_power(:, time_idx_100_150), 2);

% 找到超過0.6的點的索引
exceed_idx1 = find(avg_power_100_150 > 0.6);

% 替換每個超過0.6的點
for i = 1:length(exceed_idx1)
    idx = exceed_idx1(i);
    if idx == 1  % 第一個點，只能用後一個點的值
        avg_power_100_150(idx) = avg_power_100_150(idx + 1);
    elseif idx == length(avg_power_100_150)  % 最後一個點，只能用前一個點的值
        aavg_power_100_150(idx) = avg_power_100_150(idx - 1);
    else
        avg_power_100_150(idx) = mean([avg_power_100_150(idx - 1), avg_power_100_150(idx + 1)]);
    end
end
avg_power_100_150 = mean(avg_power_100_150);

% 計算相對變化值
relative_change = avg_power_10_60 / abs(avg_power_100_150 - avg_power_10_60);
fprintf('avg_power_10_60: %.5f\n', avg_power_10_60);
fprintf('avg_power_100_150: %.5f\n', avg_power_100_150);

% 打印相對變化值
fprintf('10-60s與100-150s變化值: %.5f\n', relative_change);

% 繪製10~60秒和100~150秒的平均功率柱狀圖
figure;
bar([avg_power_10_60, avg_power_100_150]);
title('不同時間段的平均功率');
xlabel('時間段');
ylabel('平均功率');
set(gca, 'XTickLabel', {'10-60s', '100-150s'});
grid on;
