
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
