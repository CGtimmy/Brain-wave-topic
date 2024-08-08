freq_idx = (cz_f >= 12) & (cz_f <= 28);  %布林陣列
disp(freq_idx)   %會是直的
freq_idx_row = freq_idx(:)';
disp(freq_idx_row)   %下面輸出
  Columns 1 through 29  %輸出
   0   0   0   0   0   0   0   0   0   0   0   0   0   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1   1
  Columns 30 through 58
   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
  Columns 59 through 87
   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
  Columns 88 through 116
   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0
  Columns 117 through 129
   0   0   0   0   0   0   0   0   0   0   0   0   0

cz_selected_freq = cz_f(freq_idx); %從 cz_f 中選擇出所有符合條件（在 freq_idx 中對應位置為 true）的元素，並將它們存儲在 cz_selected_freq 中 
disp(cz_selected_freq) %下面輸出(會是直的)
12.6953    13.6719    14.6484    15.6250    16.6016    17.5781    18.5547    19.5312    20.5078    21.4844    22.4609.......

%":"可以用來選取矩陣中的整行或整列 例如，A(:, j) 選取矩陣 A 的第 j 列，A(i, :) 選取矩陣 A 的第 i 行 

cz_selected_power = cz_p(freq_idx, :);   %選取 cz_p 中對應於 freq_idx 中 true 位置的所有行及這些行的所有列
cz_avg_power = mean(cz_selected_power, 1);
% 1是第二個參數，表示沿著矩陣的行方向計算平均值
%對 cz_selected_power 的每一列計算平均值，並將結果存儲在 cz_avg_power 中。結果是行向量，包含了 cz_selected_power 中每一列的平均值
