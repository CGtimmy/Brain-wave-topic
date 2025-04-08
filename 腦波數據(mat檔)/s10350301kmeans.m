run S10350301_202504092148_1.m
run S10350301_202504092205_2.m
run S10350309_20250406_1.m
run S10350309_20250406_2.m
run S10350309_20250406_3.m
run S10350309_20250406_4.m
run S10350309_20250406_5.m
score_S10350301 = [score_S10350301_1,score_S10350301_2,score_S10350309_1,score_S10350309_2,score_S10350309_3,score_S10350309_4,score_S10350309_5];
beta_mean_S10350301 = [beta_mean_S10350301_1,beta_mean_S10350301_2,beta_mean_S10350309_1,beta_mean_S10350309_2,beta_mean_S10350309_3,beta_mean_S10350309_4,beta_mean_S10350309_5];
alpha_mean_S10350301 = [alpha_mean_S10350301_1,alpha_mean_S10350301_2,alpha_mean_S10350309_1,alpha_mean_S10350309_2,alpha_mean_S10350309_3,alpha_mean_S10350309_4,alpha_mean_S10350309_5];

combined_data_S10350301 = [beta_mean_S10350301', alpha_mean_S10350301'];  % 使用 Beta 作 X 軸, Alpha 作 Y 軸

% 使用 kmeans 分群 (分成三群)
rng(1); 
num_clusters = 3;
[idx, C] = kmeans(combined_data_S10350301, num_clusters);

colors = {[0.3010 0.7450 0.9330], [0.4660 0.6740 0.1880], [0.8500 0.3250 0.0980]}; % 藍色, 綠色, 紅色

% 繪製二維散佈圖
figure;
hold on;
for i = 1:num_clusters
    scatter(combined_data_S10350301(idx == i, 1), combined_data_S10350301(idx == i, 2), 50, ...
        'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i});
end

% 設定軸標籤
title('S10350301_1 K-means','FontSize', 26);
xlabel('Beta');
ylabel('Alpha');

% 顯示群組中心
scatter(C(:,1), C(:,2), 200, 'k', 'x', 'LineWidth', 2);

% 為群組中心標註群組編號
for i = 1:num_clusters
    text(C(i, 1), C(i, 2), num2str(i), 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k', ...
         'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end

% 設定圖例
legend({'普通', '緊張', '輕鬆', '質心'}, 'Location', 'northeast','FontSize', 24);
hold off;
grid on;

% 建立包含原始數據和分群結果的新矩陣
Clus = [combined_data_S10350301,idx,score_S10350301'];

% 當第三列為 1 時，計算第四列對應數字的平均值
mean_value_group1 = mean(Clus(Clus(:, 3) == 1, 4));

% 當第三列為 2 時，計算第四列對應數字的平均值
mean_value_group2 = mean(Clus(Clus(:, 3) == 2, 4));

% 當第三列為 3 時，計算第四列對應數字的平均值
mean_value_group3 = mean(Clus(Clus(:, 3) == 3, 4));

% 顯示結果
disp(['群組 1 的 score 的平均值: ', num2str(mean_value_group1)]);
disp(['群組 2 的 score 的平均值: ', num2str(mean_value_group2)]);
disp(['群組 3 的 score 的平均值: ', num2str(mean_value_group3)]);

% 建立包含原始數據和分群結果的新矩陣
Clus = [combined_data_S10350301, idx, score_S10350301'];

% 計算每個群組的 score 平均值
mean_values = [
    mean(Clus(Clus(:, 3) == 1, 4));
    mean(Clus(Clus(:, 3) == 2, 4));
    mean(Clus(Clus(:, 3) == 3, 4));
];

% 根據平均值進行排序，取得排序後的群組編號
[~, sorted_idx] = sort(mean_values);  % sorted_idx(i) 是第 i 小的群組編號

% 建立一個映射：原始群組 → 高中低 (1~3)
mapping = zeros(3,1);
mapping(sorted_idx(1)) = 1;  % 最小
mapping(sorted_idx(2)) = 2;  % 中間
mapping(sorted_idx(3)) = 3;  % 最大

% 把分類標籤加入到 combined_data_S10350301，成為新的一欄
group_levels = mapping(idx);  % 根據原始群組標籤轉換成 1~3 的排序等級
combined_data_with_level = [combined_data_S10350301, group_levels];


% 建立新分類標籤 (根據 score_S10350301)
score_labels = zeros(size(score_S10350301)); % 先初始化
score_labels(score_S10350301 == 1 | score_S10350301 == 2) = 1;
score_labels(score_S10350301 == 3) = 2;
score_labels(score_S10350301 == 4 | score_S10350301 == 5) = 3;

% 計算與 combined_data_with_level 第 3 列的準確率
correct_predictions = sum(score_labels' == combined_data_with_level(:, 3));
accuracy = (correct_predictions / length(score_labels)) * 100;

% 顯示結果
disp(['模型分類準確率: ', num2str(accuracy), '%']);

% 5 折交叉驗證
k = 5;
cv = cvpartition(length(score_S10350301), 'KFold', k);

train_accuracies = zeros(k,1);
test_accuracies = zeros(k,1);

for i = 1:k
    % 分割訓練集與測試集
    train_idx = training(cv, i);
    test_idx = test(cv, i);

    % 訓練資料
    train_data = combined_data_with_level(train_idx, :);
    train_labels = score_labels(train_idx)';  % 轉置成列向量

    % 測試資料
    test_data = combined_data_with_level(test_idx, :);
    test_labels = score_labels(test_idx)';

    % 計算訓練集準確率
    train_correct = sum(train_data(:,3) == train_labels);
    train_accuracies(i) = (train_correct / length(train_labels)) * 100;

    % 計算測試集準確率
    test_correct = sum(test_data(:,3) == test_labels);
    test_accuracies(i) = (test_correct / length(test_labels)) * 100;

    % 顯示每折結果
    disp(['Fold ', num2str(i), ' 訓練準確率: ', num2str(train_accuracies(i)), '%']);
    disp(['Fold ', num2str(i), ' 測試準確率: ', num2str(test_accuracies(i)), '%']);
end

% 計算平均準確率
mean_train_accuracy = mean(train_accuracies);
mean_test_accuracy = mean(test_accuracies);

% % 顯示平均準確率
% disp(['平均訓練準確率: ', num2str(mean_train_accuracy), '%']);
% disp(['平均測試準確率: ', num2str(mean_test_accuracy), '%']);
% 

% 初始化平均值矩陣
beta_alpha_means = zeros(num_clusters, 2);

for i = 1:num_clusters
    beta_alpha_means(i, 1) = mean(Clus(Clus(:, 3) == i, 1));  % Beta 平均
    beta_alpha_means(i, 2) = mean(Clus(Clus(:, 3) == i, 2));  % Alpha 平均
end

% 顯示結果
for i = 1:num_clusters
    fprintf('群組 %d 的 Beta 平均值為: %.2f\n', i, beta_alpha_means(i, 1));
    fprintf('群組 %d 的 Alpha 平均值為: %.2f\n', i, beta_alpha_means(i, 2));
end
% 建立特徵與標籤
features = [beta_mean_S10350301', alpha_mean_S10350301'];

% 建立 score 標籤
score_labels = zeros(size(score_S10350301));
score_labels(score_S10350301 == 1 | score_S10350301 == 2) = 1;  % 輕鬆
score_labels(score_S10350301 == 3) = 2;                         % 普通
score_labels(score_S10350301 == 4 | score_S10350301 == 5) = 3;  % 緊張

% 移除非法資料
valid_idx = score_labels > 0;
features = features(valid_idx, :);
labels = score_labels(valid_idx)';
label_order = [1 2 3];

% =================== K-means + 交叉驗證 ====================
k = 5;
cv = cvpartition(length(labels), 'KFold', k);
total_conf_matrix = zeros(3,3);
train_accuracies = zeros(k,1);
test_accuracies = zeros(k,1);
precisions = zeros(k,1);
recalls = zeros(k,1);
f1_scores = zeros(k,1);

for i = 1:k
    train_idx = training(cv, i);
    test_idx = test(cv, i);
    
    train_X = features(train_idx, :);
    train_y = labels(train_idx);
    test_X = features(test_idx, :);
    test_y = labels(test_idx);
    fprintf('Fold %d: 總資料點數: %d, 訓練資料點數: %d, 測試資料點數: %d\n', ...
     i, length(score_S10350301), sum(train_idx), sum(test_idx));

    
    % K-means (使用訓練資料訓練)
    rng(1);
    [cluster_idx_train, cluster_centers] = kmeans(train_X, 3, 'Replicates',5);
    
    % 根據 cluster 的中心 score 計算分類順序
    center_scores = zeros(3,1);
    for j = 1:3
        center_scores(j) = mean(train_y(cluster_idx_train == j));
    end
    
    [~, order] = sort(center_scores);  % 由小至大：輕鬆→普通→緊張
    cluster_map = zeros(3,1);
    cluster_map(order(1)) = 1;
    cluster_map(order(2)) = 2;
    cluster_map(order(3)) = 3;
    
    % 訓練資料分類結果
    pred_train_clusters = cluster_map(cluster_idx_train);
    train_accuracies(i) = sum(pred_train_clusters == train_y) / length(train_y) * 100;
    
    % 測試資料 → 對每筆 test_X 找最近的中心
    D = pdist2(test_X, cluster_centers); % 距離矩陣
    [~, nearest_center] = min(D, [], 2);
    pred_test = cluster_map(nearest_center);
    
    % 測試準確率
    test_accuracies(i) = sum(pred_test == test_y) / length(test_y) * 100;
    
    % 混淆矩陣
    conf = confusionmat(test_y, pred_test, 'Order', label_order);
    total_conf_matrix = total_conf_matrix + conf;
    
    % Precision / Recall / F1
    precision_per_class = diag(conf) ./ sum(conf,1)';
    recall_per_class = diag(conf) ./ sum(conf,2);
    f1_per_class = 2 * (precision_per_class .* recall_per_class) ./ (precision_per_class + recall_per_class);

    precision_per_class(isnan(precision_per_class)) = 0;
    recall_per_class(isnan(recall_per_class)) = 0;
    f1_per_class(isnan(f1_per_class)) = 0;

    precisions(i) = mean(precision_per_class);
    recalls(i) = mean(recall_per_class);
    f1_scores(i) = mean(f1_per_class);

    disp(['Fold ', num2str(i), ' 混淆矩陣:']);
    disp(conf);
    disp(['Fold ', num2str(i), ' 訓練準確率: ', num2str(train_accuracies(i)), '%']);
    disp(['Fold ', num2str(i), ' 測試準確率: ', num2str(test_accuracies(i)), '%']);
    disp(['Fold ', num2str(i), ' Recall: ', num2str(recalls(i))]);
    disp(['Fold ', num2str(i), ' Precision: ', num2str(precisions(i))]);
    disp(['Fold ', num2str(i), ' F1-score: ', num2str(f1_scores(i))]);
    disp('----------------------------------------------');
end

% =================== 報告總結 ====================
mean_train_accuracy = mean(train_accuracies);
mean_test_accuracy = mean(test_accuracies);
mean_recall = mean(recalls);
mean_precision = mean(precisions);
mean_f1 = mean(f1_scores);

disp(['平均訓練準確率: ', num2str(mean_train_accuracy), '%']);
disp(['平均測試準確率: ', num2str(mean_test_accuracy), '%']);
disp(['平均 Recall: ', num2str(mean_recall)]);
disp(['平均 Precision: ', num2str(mean_precision)]);
disp(['平均 F1-score: ', num2str(mean_f1)]);

% =================== 畫混淆矩陣 ====================
figure;
imagesc(total_conf_matrix);
blues = [linspace(1, 0.5, 100)', linspace(1, 0.8, 100)', ones(100, 1)];
colormap(blues);
colorbar;
xlabel('Predicted Label');
ylabel('True Label');
title('K-means Confusion Matrix','FontSize', 23);
textStrings = string(total_conf_matrix);
[x, y] = meshgrid(1:3);
text(x(:), y(:), textStrings(:), 'HorizontalAlignment', 'center', 'FontSize', 14, 'Color', 'k');
axis square;
set(gca, 'XTick', 1:3, 'XTickLabel', {'1:輕鬆', '2:普通', '3:緊張'}, ...
         'YTick', 1:3, 'YTickLabel', {'1:輕鬆', '2:普通', '3:緊張'},'FontSize', 23);

% =================== 分類報告 ====================
class_names = {'1:輕鬆', '2:普通', '3:緊張'};
report_precision = diag(total_conf_matrix) ./ sum(total_conf_matrix, 1)';
report_recall = diag(total_conf_matrix) ./ sum(total_conf_matrix, 2);
report_f1 = 2 * (report_precision .* report_recall) ./ (report_precision + report_recall);
support = sum(total_conf_matrix, 2);

report_precision(isnan(report_precision)) = 0;
report_recall(isnan(report_recall)) = 0;
report_f1(isnan(report_f1)) = 0;

fprintf('\n分類報告 (K-means Classification Report):\n');
fprintf('%-10s %-10s %-10s %-10s %-10s\n', '類別', 'Precision', 'Recall', 'F1-score', 'Support');
for i = 1:3
    fprintf('%-10s %-10.2f %-10.2f %-10.2f %-10d\n', ...
        class_names{i}, ...
        report_precision(i), ...
        report_recall(i), ...
        report_f1(i), ...
        support(i));
end

macro_precision = mean(report_precision);
macro_recall = mean(report_recall);
macro_f1 = mean(report_f1);
total_support = sum(support);
weighted_precision = sum(report_precision .* support) / total_support;
weighted_recall = sum(report_recall .* support) / total_support;
weighted_f1 = sum(report_f1 .* support) / total_support;

fprintf('\n%-10s %-10.2f %-10.2f %-10.2f\n', 'Macro avg', macro_precision, macro_recall, macro_f1);
fprintf('%-10s %-10.2f %-10.2f %-10.2f\n', 'Weighted avg', weighted_precision, weighted_recall, weighted_f1);

