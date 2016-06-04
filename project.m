clc;
clear all;
close all;

%%%TASK 1
values = 1:10;
values(11:13) = 10;
vv = values;
%The following histogram shows the card values of just one suit because
%it's same in other suits.
figure(1);histogram(vv);
vv_mean = mean(vv);
vv_median = median(vv);
vv_var = var(vv);
vv_std = std(vv);

%%%TASK 2
cards = 1:13;
lc = length(cards);
sums = [];
sample_count = 1000;
sample_size = 3;

for i=1:sample_count;
%      disp(sprintf ( '\n') )
     cards = cards(randperm(length(cards)));
%      disp(cards)
     a= cards(randi([1 lc],1,3));
%      disp(a);
     cs = sum(values(a));
     sums(end+1) = cs;
end
sums;

s_mean = mean(sums);
s_median = median(sums);
s_var = var(sums);
s_std = std(sums);

%%%TASK 3
sprintf('Mean of the Card sums: %f \nMedian of the Card sums: %f \nVariance of the Card sums: %f \nStandard Deviation of the Card sums: %f\nOriginal mean: %f (%f)\nOriginal median: %f (%f)\nOriginal variance: %f (%f)\nOriginal standard deviation: %f (%f)', s_mean, s_median, s_var, s_std, vv_mean, vv_mean*3.0, vv_median, vv_median*3.0, vv_var, vv_var*3.0, vv_std, vv_std*3.0)

%%%TASK 4
figure(2);histogram(sums);

%%%TASK 5
%% Estimating the values of future draws (using Chebyshev's inequality)
%Approach 1
estimate1a = round(s_mean - sqrt(10) * s_std);
estimate1b = round(s_mean + sqrt(10) * s_std);

%Approach 2 (using Z-score)
estimate2_L = round(s_mean + (-1.555*s_std));
estimate2_U = round(s_mean + (1.645*s_std));

%Probability of getting a draw value of at least 20
prob = 1-normcdf((20-s_mean)/s_std);

%Approach 3
% The "sums" can only take values in the range 3-30
low = 1; high = 31;
counts(low:high) = 0;
counts(sums) = 1;
sc = sum(counts);

while (sum(counts(low:high))/sc>0.9)
    if counts(low) <= counts(high)
        low = low+1;
    else
        high = high-1;
    end
end
prob2 = sum(counts(21:31))/sc;
sprintf('The approximate value pairs for both methods are: (%d,%d) and (%d,%d)\nThe probability of getting a draw value of at least 20 is: %f\n\nAnother fast method gives this pair: (%d,%d)\nThe probability of drawing 3 cards whose sum is at least 20: %f', estimate1a, estimate1b, estimate2_L, estimate2_U, prob, low, high, prob2)


