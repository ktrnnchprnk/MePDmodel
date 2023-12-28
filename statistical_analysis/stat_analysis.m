clearvars; clc;
[num_data, txt_data, raw_data] = xlsread("data_mod.csv");
Mean = mean(num_data, 'omitnan');
sd_data = nanstd(num_data);

% Statistical analysis for 2 Hz stimulation
data1 =  num_data(:,5);
data2 =  num_data(:,6);
[h, p, ci, stats] = ttest2(data1, data2);
[h1, p1] = vartest2(data1, data2);
% Display results
fprintf('---------------------------------\n');
fprintf('Independent Sample t-test Results for 2 Hz:\n');
fprintf('Hypothesis test: Mean of data1 = Mean of data2\n');
fprintf('t-statistic: %.4f\n', stats.tstat);
fprintf('Degrees of freedom: %d\n', stats.df);
fprintf('P-value: %.4f\n', p);
disp(['F-test: ', num2str(p1)]);
fprintf('95%% Confidence Interval for the difference of means: [%.4f, %.4f]\n', ci(1), ci(2));
if h == 1
    fprintf('Reject the null hypothesis at the 5%% significance level.\n');
else
    fprintf('Fail to reject the null hypothesis at the 5%% significance level.\n');
end

% Statistical analysis for 5 Hz stimulation
data1 =  num_data(:,7);
data2 =  num_data(:,8);
[h, p, ci, stats] = ttest2(data1, data2);
[h1, p1] = vartest2(data1, data2);
% Display results
fprintf('---------------------------------\n');
fprintf('Independent Sample t-test Results for 5 Hz:\n');
fprintf('Hypothesis test: Mean of data1 = Mean of data2\n');
fprintf('t-statistic: %.4f\n', stats.tstat);
fprintf('Degrees of freedom: %d\n', stats.df);
fprintf('P-value: %.4f\n', p);
disp(['F-test: ', num2str(p1)]);
fprintf('95%% Confidence Interval for the difference of means: [%.4f, %.4f]\n', ci(1), ci(2));
if h == 1
    fprintf('Reject the null hypothesis at the 5%% significance level.\n');
else
    fprintf('Fail to reject the null hypothesis at the 5%% significance level.\n');
end

% Statistical analysis for 10 Hz stimulation
data1 =  num_data(:,9);
data2 =  num_data(:,10);
[h, p, ci, stats] = ttest2(data1, data2);
[h1, p1] = vartest2(data1, data2);
% Display results
fprintf('---------------------------------\n');
fprintf('Independent Sample t-test Results for 10 Hz:\n');
fprintf('Hypothesis test: Mean of data1 = Mean of data2\n');
fprintf('t-statistic: %.4f\n', stats.tstat);
fprintf('Degrees of freedom: %d\n', stats.df);
fprintf('P-value: %.4f\n', p);
disp(['F-test: ', num2str(p1)]);
fprintf('95%% Confidence Interval for the difference of means: [%.4f, %.4f]\n', ci(1), ci(2));
if h == 1
    fprintf('Reject the null hypothesis at the 5%% significance level.\n');
else
    fprintf('Fail to reject the null hypothesis at the 5%% significance level.\n');
end

% Statistical analysis for 20 Hz stimulation
data1 =  num_data(:,9);
data2 =  num_data(:,10);
[h, p, ci, stats] = ttest2(data1, data2);
[h1, p1] = vartest2(data1, data2);
% Display results
fprintf('---------------------------------\n');
fprintf('Independent Sample t-test Results for 2 Hz:\n');
fprintf('Hypothesis test: Mean of data1 = Mean of data2\n');
fprintf('t-statistic: %.4f\n', stats.tstat);
fprintf('Degrees of freedom: %d\n', stats.df);
fprintf('P-value: %.4f\n', p);
disp(['F-test: ', num2str(p1)]);
fprintf('95%% Confidence Interval for the difference of means: [%.4f, %.4f]\n', ci(1), ci(2));
if h == 1
    fprintf('Reject the null hypothesis at the 5%% significance level.\n');
else
    fprintf('Fail to reject the null hypothesis at the 5%% significance level.\n');
end