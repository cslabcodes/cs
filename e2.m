clc
close all
clear

%COINS
% Number of dice
numDice = 1;
% Number of dice rolls
numRolls = 10000;
% Simulate rolling 'numDice' dice and calculate the sum
diceSum = randi([1, 2], numRolls, numDice);
sumValues = sum(diceSum, 2);
% Calculate the probability distribution
numOutcomes = numDice * 2; % Possible outcomes for 'numDice' dice
probDistribution = histcounts(sumValues, numDice:numOutcomes + 1) / numRolls;
% Plotting
figure(1);
bar(numDice:numOutcomes, probDistribution);
title(['Probability Distribution of Sum of ' num2str(numDice) ' Coins']);
xlabel('Possible Sum Outcomes');
ylabel('Probability');

%DICE
numdice=3;
numrolls=10000;
dicesum=randi([1,6],numrolls,numdice);
sumvalues=sum(dicesum,2);
numoutcomes=6*numdice;
prob=histcounts(sumvalues,numdice:numoutcomes+1)/numrolls;
figure(2);
bar(numdice:numoutcomes,prob);
title("Central limit theorem for 2 dice");
ylabel("probability")
xlabel('Possible outcomes')
