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
