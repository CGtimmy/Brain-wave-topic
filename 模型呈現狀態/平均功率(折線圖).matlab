%平均功率折線圖
% 選擇頻率範圍在12到28Hz
freq_idx = (cz_f >= 12) & (cz_f <= 28);
cz_selected_freq = cz_f(freq_idx);
cz_selected_power = cz_p(freq_idx, :);

% 計算平均功率
cz_avg_power = mean(cz_selected_power, 1);
% 找到超過1的點的索引
exceed_idx = find(cz_avg_power > 0.6);

% 替換每個超過1的點
for i = 1:length(exceed_idx)
    idx = exceed_idx(i);
    if idx == 1  % 第一個點，只能用後一個點的值
        cz_avg_power(idx) = cz_avg_power(idx + 1);
    elseif idx == length(cz_avg_power)  % 最後一個點，只能用前一個點的值
        cz_avg_power(idx) = cz_avg_power(idx - 1);
    else
        cz_avg_power(idx) = mean([cz_avg_power(idx - 1), cz_avg_power(idx + 1)]);
    end
end

% 繪製折線圖Beta波
figure;
plot(cz_t, cz_avg_power, 'LineWidth', 2);
title('12-28Hz平均功率');
xlabel('Time (seconds)');
ylabel('平均功率');
grid on;
xlim([0 max(cz_t)]);
xticks(0:10:max(cz_t)) 
ylim([0 1]);
yticks(0:0.05:1) 

% 選擇頻率範圍在8到12Hz
freq_idx1 = (cz_f >= 8) & (cz_f <= 12);
cz_selected_freq1 = cz_f(freq_idx1);
cz_selected_power1 = cz_p(freq_idx1, :);
% 計算平均功率
cz_avg_power1 = mean(cz_selected_power1, 1);

% 繪製折線圖Alpha波
figure;
plot(cz_t, cz_avg_power1, 'LineWidth', 2);
title('8-12Hz平均功率');
xlabel('Time (seconds)');
ylabel('平均功率');
grid on;
xlim([0 max(cz_t)]);
xticks(0:10:max(cz_t)) 
ylim([0 5]);
yticks(0:0.1:5) 
