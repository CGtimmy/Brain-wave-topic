% 將 beta 和 alpha 數據組合成一個矩陣
boxes_combined_data_baseline_Short = [beta_mean_baseline_Short', alpha_mean_baseline_Short'];

% % 繪製盒狀圖
% figure;
% boxplot(boxes_combined_data_baseline_Short, 'Labels', {'Beta(12-28Hz)', 'Alpha(8-12Hz)'}, ...
%     'OutlierSize', 20, ...  % 調整離群值大小
%     'Symbol', '*', ...      % 設置離群值的符號
%     'Colors', 'b');         % 設置箱型圖的顏色（但不會影響離群值）
% 
% h = findobj(gca, 'Tag', 'Outliers');
% set(h, 'MarkerEdgeColor', 'r', 'MarkerSize', 20);  % 設置為紅色，並增加大小
% 
% title('Short baseline(1~60s) 盒壯圖 12-28Hz 和 8-12Hz');
% ylabel('能量');
% xlabel('腦波類型');
