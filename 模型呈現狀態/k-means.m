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

% 顏色函數定義
function color = getColor(clusterIndex)
    colors = {'blue', 'red', 'green'};
    color = colors{clusterIndex};
end


% k-means 
num_clusters = 2;  % 分成兩群
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
gscatter(beta_mean, alpha_mean, idx, 'br', '.', 8);  % 使用兩種顏色，藍色和紅色
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
legend('被嚇到', '正在認真', 'Centroids', 'alpha = beta');
legend('Location', 'northeastoutside');

hold off;

% 颜色函数定义
function color = getColor(clusterIndex)
    colors = {'blue', 'red'};
    color = colors{clusterIndex};
end
