% time limit
time_min = 0;
time_max = 430;
time_mask = (cz_t >= time_min) & (cz_t <= time_max);
filtered_time = cz_t(time_mask);
filtered_power = cz_avg_power(time_mask);

% %每1秒計算
window_size = 1; % s
time_intervals = floor(filtered_time / window_size); %每1s一個區間
unique_intervals = unique(time_intervals); %find all block

% 每s平均功率
avg_power_per_interval = arrayfun(@(x) mean(filtered_power(time_intervals == x)), unique_intervals);

% 每s功率增長率
interval_diff = diff(avg_power_per_interval); % 每s功率變化
time_diff = window_size; 
growth_rate_per_interval = (interval_diff / time_diff) * 100;

%折線圖
figure;
plot(unique_intervals(2:end) * window_size, growth_rate_per_interval, 'LineWidth', 2);
title('12-28 Hz 功率增長率');
xlabel('Time (sec）');
ylabel('增長率 (%)');
grid on
xlim([time_min time_max]);
xticks(time_min:10:time_max) %每幾秒顯示一個刻度
ylim([-30 30]);
