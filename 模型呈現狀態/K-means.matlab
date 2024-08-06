
% 定義頻率範圍
freq_range_alpha = (cz_f >= 8 & cz_f <= 12);
freq_range_beta = (cz_f >= 20 & cz_f <= 28);

% 定義時間段
segments = [
    10, 50;
    160,180;
    240, 260;
    310,340
];

% 初始化
data_points = [];

% 計算基線時間段的平均功率
baseline_start = segments(1, 1);
baseline_end = segments(1, 2);
time_idx_baseline = cz_t >= baseline_start & cz_t <= baseline_end;
cz_p_baseline = cz_p(:, time_idx_baseline);

% 計算基線時間段的平均功率
baseline_avg_power_alpha = mean(mean(cz_p(freq_range_alpha, time_idx_baseline), 2));
baseline_avg_power_beta = mean(mean(cz_p(freq_range_beta, time_idx_baseline), 2));

% 處理基線時間段的數據點
for j = 1:size(cz_p_baseline, 2)
    avg_power_alpha = mean(cz_p(freq_range_alpha, j));
    avg_power_beta = mean(cz_p(freq_range_beta, j));
    data_points = [data_points; avg_power_alpha, avg_power_beta];
end

% 處理其他時間段
for i = 2:size(segments, 1)
    start_time = segments(i, 1);
    end_time = segments(i, 2);
    
    % 找到對應時間索引
    time_idx = cz_t >= start_time & cz_t <= end_time;
    
    % 提取對應時間功率
    cz_p_segment = cz_p(:, time_idx);
    
    % 計算每個時間窗口的Alpha波和Beta波的平均功率
    for j = 1:size(cz_p_segment, 2)
        avg_power_alpha = mean(cz_p(freq_range_alpha, j));
        avg_power_beta = mean(cz_p(freq_range_beta, j));
        
        % 计算相对基线的差异
        alpha_diff = abs(avg_power_alpha - baseline_avg_power_alpha);
        beta_diff = abs(avg_power_beta - baseline_avg_power_beta);
        
        % 将计算结果添加到数据点数组中
        data_points = [data_points; alpha_diff, beta_diff];
    end
end

% 删除 Beta 波平均功率大於 1 的點
data_points = data_points(data_points(:, 2) <= 1, :);
% 删除 Alpha 波平均功率大於 3 的點
data_points = data_points(data_points(:, 1) <= 3, :);

% 檢查點點數量
num_data_points = size(data_points, 1);
fprintf('数据点数量: %d\n', num_data_points);

num_clusters = 2; % 分兩類

if num_data_points >= num_clusters
    [idx, C] = kmeans(data_points, num_clusters);

    figure;
    hold on;
    colors = ['r', 'b']; 
    for i = 1:num_clusters
        cluster_data = data_points(idx == i, :);
        scatter(cluster_data(:, 1), cluster_data(:, 2), 50, colors(i), 'filled');
    end

    % 繪製質心
    scatter(C(:, 1), C(:, 2), 100, 'k', 'x');
    xlim([min(data_points(:,1))-0.1, max(data_points(:,1))+0.1]);
    ylim([min(data_points(:,2))-0.1, max(data_points(:,2))+0.1]);
    title('K-means');
    xlabel('Alpha波 (8-12 Hz) 平均功率');
    ylabel('Beta波 (12-28 Hz) 平均功率');
    legend('第一類', '第二類', '質心');
    grid on;
    hold off;
else
    disp('點點不足。');
end

