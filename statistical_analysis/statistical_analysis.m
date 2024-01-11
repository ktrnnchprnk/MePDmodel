clearvars; clc;
num_data = readmatrix("data_mod.csv");
Mean = mean(num_data, 'omitnan');
sd_data = std(num_data,'omitnan')/sqrt(size(num_data,1));

% Statistical analysis for 2 Hz stimulation
data1 =  num_data(:,5);
data2 =  num_data(:,6);
% Combine the data and create a grouping variable
allData = [data1; data2];
group = [ones(size(data1)); 2*ones(size(data2))]; 

% Perform one-way ANOVA
[p_anova, tbl_anova, stats_anova] = anova1(allData, group, 'off');

% Perform post-hoc Tukey's test for pairwise comparisons
[c,~,~,gnames] = multcompare(stats_anova, 'Display', 'off');

% Display ANOVA results
disp('ANOVA Results for 2 Hz:')
disp(tbl_anova)

% Display pairwise comparisons using Tukey's test
disp('Tukey HSD Pairwise Comparisons:')
pairwise_comp = table(gnames(c(:,1)), gnames(c(:,2)), c(:,3), c(:,6), ...
    'VariableNames', {'Group1', 'Group2', 'Difference', 'P_Value'});
disp(pairwise_comp)


% Statistical analysis for 5 Hz stimulation
data1 =  num_data(:,7);
data2 =  num_data(:,8);
% Combine the data and create a grouping variable
allData = [data1; data2];
group = [ones(size(data1)); 2*ones(size(data2))]; 

% Perform one-way ANOVA
[p_anova, tbl_anova, stats_anova] = anova1(allData, group, 'off');

% Perform post-hoc Tukey's test for pairwise comparisons
[c,~,~,gnames] = multcompare(stats_anova, 'Display', 'off');

% Display ANOVA results
disp('ANOVA Results for 5 Hz:')
disp(tbl_anova)

% Display pairwise comparisons using Tukey's test
disp('Tukey HSD Pairwise Comparisons:')
pairwise_comp = table(gnames(c(:,1)), gnames(c(:,2)), c(:,3), c(:,6), ...
    'VariableNames', {'Group1', 'Group2', 'Difference', 'P_Value'});
disp(pairwise_comp)

% Statistical analysis for 10 Hz stimulation
data1 =  num_data(:,9);
data2 =  num_data(:,10);

% Combine the data and create a grouping variable
allData = [data1; data2];
group = [ones(size(data1)); 2*ones(size(data2))]; 

% Perform one-way ANOVA
[p_anova, tbl_anova, stats_anova] = anova1(allData, group, 'off');

% Perform post-hoc Tukey's test for pairwise comparisons
[c,~,~,gnames] = multcompare(stats_anova, 'Display', 'off');

% Display ANOVA results
disp('ANOVA Results for 10 Hz:')
disp(tbl_anova)

% Display pairwise comparisons using Tukey's test
disp('Tukey HSD Pairwise Comparisons:')
pairwise_comp = table(gnames(c(:,1)), gnames(c(:,2)), c(:,3), c(:,6), ...
    'VariableNames', {'Group1', 'Group2', 'Difference', 'P_Value'});
disp(pairwise_comp)

% Statistical analysis for 20 Hz stimulation
data1 =  num_data(:,11);
data2 =  num_data(:,12);

% Combine the data and create a grouping variable
allData = [data1; data2];
group = [ones(size(data1)); 2*ones(size(data2))]; 

% Perform one-way ANOVA
[p_anova, tbl_anova, stats_anova] = anova1(allData, group, 'off');

% Perform post-hoc Tukey's test for pairwise comparisons
[c,~,~,gnames] = multcompare(stats_anova, 'Display', 'off');

% Display ANOVA results
disp('ANOVA Results for 20 Hz:')
disp(tbl_anova)

% Display pairwise comparisons using Tukey's test
disp('Tukey HSD Pairwise Comparisons:')
pairwise_comp = table(gnames(c(:,1)), gnames(c(:,2)), c(:,3), c(:,6), ...
    'VariableNames', {'Group1', 'Group2', 'Difference', 'P_Value'});
disp(pairwise_comp)