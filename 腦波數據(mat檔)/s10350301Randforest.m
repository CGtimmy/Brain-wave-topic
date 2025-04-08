% 整理特徵與標籤
features = [beta_mean_S10350301', alpha_mean_S10350301'];
score_labels = zeros(size(score_S10350301));
score_labels(score_S10350301 == 1 | score_S10350301 == 2) = 1;
score_labels(score_S10350301 == 3 | score_S10350301 == 4) = 2;
score_labels(score_S10350301 == 5) = 3;

valid_idx = score_labels > 0;
features = features(valid_idx, :);
labels = score_labels(valid_idx)';
beta_used = beta_mean_S10350301(valid_idx)';
alpha_used = alpha_mean_S10350301(valid_idx)';
score_used = score_S10350301(valid_idx);
class_names = {'1:輕鬆', '2:普通', '3:緊張'};

% 整理特徵與標籤
features = [beta_mean_S10350301', alpha_mean_S10350301'];
score_labels = zeros(size(score_S10350301));
score_labels(score_S10350301 == 1 | score_S10350301 == 2) = 1;
score_labels(score_S10350301 == 3 | score_S10350301 == 4) = 2;
score_labels(score_S10350301 == 5) = 3;

valid_idx = score_labels > 0;
features = features(valid_idx, :);
labels = score_labels(valid_idx)';

% 指定下載資料夾路徑
download_folder = '/Users/hoyi/Downloads/';

% 將特徵和標籤合併為表格 (更容易添加列名)
data_table = table(labels, features(:,1), features(:,2), ...
    'VariableNames', {'label', 'beta_mean', 'alpha_mean'});

% 完整檔案路徑
csv_filepath = fullfile(download_folder, 'eeg_features_labels.csv');

% 寫入CSV文件
writetable(data_table, csv_filepath);

disp(['數據已成功導出至: ' csv_filepath]);

% 特徵標準化
[features_scaled, mu, sigma] = zscore(features);

% 建立交叉驗證
k = 5;
cv = cvpartition(length(labels), 'KFold', k);
train_accuracies = zeros(k,1);
test_accuracies = zeros(k,1);
conf_matrices = cell(k,1);
recalls = zeros(k,1);
precisions = zeros(k,1);
f1_scores = zeros(k,1);
total_conf_matrix = zeros(3, 3);

for i = 1:k
    train_idx = training(cv, i);
    test_idx = test(cv, i);

    X_train = features_scaled(train_idx, :);
    y_train = labels(train_idx);
    X_test = features_scaled(test_idx, :);
    y_test = labels(test_idx);

    RF_model = fitcensemble(X_train, y_train, ...
        'Method', 'Bag', ...
        'NumLearningCycles', 100, ...
        'Learners', 'tree');

    train_pred = predict(RF_model, X_train);
    test_pred = predict(RF_model, X_test);

    train_accuracies(i) = sum(train_pred == y_train) / length(y_train) * 100;
    test_accuracies(i) = sum(test_pred == y_test) / length(y_test) * 100;

    unique_labels = unique([y_test; test_pred]);
    conf = confusionmat(y_test, test_pred, 'Order', unique_labels);
    conf_padded = zeros(3,3);
    for a = 1:length(unique_labels)
        for b = 1:length(unique_labels)
            row = unique_labels(a);
            col = unique_labels(b);
            if row > 0 && col > 0
                conf_padded(row, col) = conf(a,b);
            end
        end
    end

    conf_matrices{i} = conf_padded;
    total_conf_matrix = total_conf_matrix + conf_padded;

    precision_per_class = diag(conf_padded) ./ sum(conf_padded, 1)';
    recall_per_class = diag(conf_padded) ./ sum(conf_padded, 2);
    f1_per_class = 2 * (precision_per_class .* recall_per_class) ./ (precision_per_class + recall_per_class);

    precision_per_class(isnan(precision_per_class)) = 0;
    recall_per_class(isnan(recall_per_class)) = 0;
    f1_per_class(isnan(f1_per_class)) = 0;

    precisions(i) = mean(precision_per_class);
    recalls(i) = mean(recall_per_class);
    f1_scores(i) = mean(f1_per_class);

    % 顯示每折結果
    disp(['Fold ', num2str(i), ' 訓練準確率: ', num2str(train_accuracies(i)), '%']);
    disp(['Fold ', num2str(i), ' 測試準確率: ', num2str(test_accuracies(i)), '%']);
    disp(['Fold ', num2str(i), ' Recall: ', num2str(recalls(i))]);
    disp(['Fold ', num2str(i), ' Precision: ', num2str(precisions(i))]);
    disp(['Fold ', num2str(i), ' F1-score: ', num2str(f1_scores(i))]);
    disp(['Fold ', num2str(i), ' 混淆矩陣:']);
    disp(conf_padded);
    disp('----------------------------------------------');
end

% 平均結果
mean_train_accuracy = mean(train_accuracies);
mean_test_accuracy = mean(test_accuracies);
mean_recall = mean(recalls);
mean_precision = mean(precisions);
mean_f1 = mean(f1_scores);

disp(['平均訓練準確率 (Random Forest): ', num2str(mean_train_accuracy), '%']);
disp(['平均測試準確率 (Random Forest): ', num2str(mean_test_accuracy), '%']);
disp(['平均 Recall: ', num2str(mean_recall)]);
disp(['平均 Precision: ', num2str(mean_precision)]);
disp(['平均 F1-score: ', num2str(mean_f1)]);

disp('總混淆矩陣 (所有 fold 測試資料累加):');
disp(total_conf_matrix);

% ======== 分類報告 (Classification Report) ========
report_precision = diag(total_conf_matrix) ./ sum(total_conf_matrix, 1)';
report_recall = diag(total_conf_matrix) ./ sum(total_conf_matrix, 2);
report_f1 = 2 * (report_precision .* report_recall) ./ (report_precision + report_recall);
support = sum(total_conf_matrix, 2);

report_precision(isnan(report_precision)) = 0;
report_recall(isnan(report_recall)) = 0;
report_f1(isnan(report_f1)) = 0;

fprintf('\n分類報告 (Overall Classification Report):\n');
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

% ======== 各類別的 score/alpha/beta 平均 ========
fprintf('\n每一類別的平均值統計：\n');
fprintf('%-10s %-10s %-10s %-10s\n', '類別', 'Score均值', 'Alpha均值', 'Beta均值');
for cls = 1:3
    idx = labels == cls;
    mean_score = mean(score_used(idx));
    mean_alpha = mean(alpha_used(idx));
    mean_beta = mean(beta_used(idx));
    fprintf('%-10s %-10.2f %-10.2f %-10.2f\n', ...
        class_names{cls}, mean_score, mean_alpha, mean_beta);
end

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


% 最後整體訓練一個模型並儲存起來
final_model = fitcensemble(features_scaled, labels, ...
    'Method', 'Bag', ...
    'NumLearningCycles', 100, ...
    'Learners', 'tree');



