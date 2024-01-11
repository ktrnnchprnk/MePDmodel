clearvars

load('colour.mat')
addpath('PeriodData')
load("PeriodBoth.dat")
load("glutr1.dat")
load("glutr2.dat")

endy=2;


Stable=NaN(length(glutr1),4);

for i =1:length(glutr1)
    Stable(i,1)=glutr1(i,1);
    Stable(i,2) = glutr1(i,3);
    Stable(i,3) = glutr1(i,4);
    Stable(i,4) = glutr1(i,5);
     if glutr1(i+1,6)==1 && glutr1(i,6)==3
        break
    end
end

% Define the location of Hopf (HB) and limit point (LP) bifurcation
% based on the change of stable eigenvalue count

HB = zeros(1,4);
LP = zeros(2,4);

for i=1:length(glutr1)-1

    if glutr1(i+1,6)==1 && glutr1(i,6)==3
        HB(1,1)=glutr1(i,1);
        HB(1,2)=glutr1(i,3);
        HB(1,3)=glutr1(i,4);
        HB(1,4)=glutr1(i,5);
    else

    end
end


f=figure(1); clf;
f.Units="centimeters";
% f.OuterPosition = [3 3 16 21];

f.OuterPosition = [3 3 13 20];


subplot(3,1,2)
hold on; box on; grid off; 
set ( gca , 'FontSize' , 8 , 'fontname' , 'Arial','FontWeight', 'bold');
plot(PeriodBoth(:,1), PeriodBoth(:,8), 'LineWidth', 1.5, 'Color','k','LineStyle','-')
% plot(PeriodGlut(:,1), PeriodGlut(:,8), 'LineWidth', 1.5, 'Color','k','LineStyle','--')
% plot(PeriodGABA(:,1), PeriodGABA(:,8), 'LineWidth', 1.5, 'Color','k','LineStyle',':')

plot(PeriodBoth(7525,1), PeriodBoth(7525,8),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 5,'LineWidth',0.7)
% plot(PeriodGlut(950,1), PeriodGlut(950,8),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 6,'LineWidth',0.7)
% plot(PeriodGABA(2634,1), PeriodGABA(2634,8),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 6,'LineWidth',0.7)


title('b')
xlim([0 endy])

xlabel('Stimulation')
ylabel('Average KNDy IPI (min) ')

% legend('$\;\;\;j_lG_l-j_eG_e$', 'Interpreter','latex')
%
ylim([10 16])
xlim([0 endy])
% legend('Both GABA and Glut', 'Glut input', 'GABA input' )

text(PeriodBoth(7525,1), PeriodBoth(7525,8), 'TR  ', 'FontSize', 9, 'fontweight', 'bold', 'HorizontalAlignment', 'right');
% text(PeriodGlut(950,1), PeriodGlut(950,8), 'TR ', 'FontSize', 9, 'HorizontalAlignment', 'right');
% text(PeriodGABA(2634,1), PeriodGABA(2634,8), 'TR ', 'FontSize', 9, 'HorizontalAlignment', 'right');



hold off


jl=1.5;
je=0.5;
subplot(3,1,3)
hold on; box on; grid off; 
set ( gca , 'FontSize' , 8 , 'fontname' , 'Arial','FontWeight', 'bold');
plot(Stable(:,1), jl*Stable(:,2), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(Stable(:,1), je*Stable(:,4), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)

plot(glutr2(:,1),jl*glutr2(:,3),'Color',colour.green,'LineWidth',1.5)
plot(glutr2(:,1),jl*glutr2(:,7),'Color',colour.green,'LineWidth',1.5)
% 
plot(glutr2(:,1),je*glutr2(:,5),'Color',colour.red,'LineWidth',1.5)
plot(glutr2(:,1),je*glutr2(:,8),'Color',colour.red,'LineWidth',1.5)
% 
plot(HB(:,1), jl*HB(:,2),'o','MarkerFaceColor','k','MarkerEdgeColor', ...
    'black', 'MarkerSize', 5,'LineWidth',1)
plot(HB(:,1), je*HB(:,4),'o','MarkerFaceColor','k','MarkerEdgeColor', ...
    'black', 'MarkerSize', 5,'LineWidth',1)
Hopf = '  HB '; 
text(HB(1,1)-0.01,je*HB(1,4)+0.025, Hopf, 'FontSize', 9,'fontweight', 'bold', 'HorizontalAlignment', 'right');
% text(HB(1,1),jl*HB(1,2), Hopf, 'FontSize', 9, 'HorizontalAlignment', 'right');

title('c')
xlim([0 endy])
ylim([0 0.3])
xlabel('Stimulation', 'FontName','Arial', 'FontWeight','bold')
ylabel('MePD input to KNDy (Hz)')

legend( 'Glu', 'GABA_{eff}',Location='northwest');


% legend('Glutamatergic contribution', 'GABAergic contribution',Location='northwest'

axes ('Units', 'centimeters','Position',[1.5 12.1 10 4])
% axis off
set ( gca , 'FontSize' , 9 , 'fontname' , 'Arial','FontWeight', 'bold');
title('a')
num_data = readmatrix("data_mod.csv");
Mean = mean(num_data, 'omitnan');
% Calculate SEM for each column
for col = 1:size(num_data, 2)
    current_column = num_data(:, col);
    sem(col) = std(current_column,'omitnan') / sqrt(sum(~isnan(current_column)));
end
hold on; box on;
bar(2,Mean(1),0.7, 'FaceColor','w')
bar(2.7,Mean(2),0.7, 'FaceColor',colour.purple)
bar(0.2,Mean(3),0.7, 'FaceColor','w')
bar(0.9,Mean(4),0.7, 'FaceColor',colour.grey)
bar(3.8,Mean(5),0.7, 'FaceColor','w')
bar(4.5,Mean(6),0.7, 'FaceColor',colour.purple)
bar(5.6,Mean(7),0.7, 'FaceColor','w')
bar(6.3,Mean(8),0.7, 'FaceColor',colour.purple)
bar(7.4,Mean(9),0.7, 'FaceColor','w')
bar(8.1,Mean(10), 0.7,'FaceColor',colour.purple)
bar(9.2,Mean(11),0.7, 'FaceColor','w')
bar(9.9,Mean(12), 0.7,'FaceColor',colour.purple)
errorbar([3.8,4.5,5.6,6.3,7.4,8.1,9.2,9.9], Mean(5:12), sem(5:12), 'k.', 'LineWidth', 1.5);
errorbar([0.2, 0.9], Mean(3:4), sem(3:4), 'k.', 'LineWidth', 1.5);
errorbar([2, 2.7], Mean(1:2), sem(1:2), 'k.', 'LineWidth', 1.5);

scatter([0.0 0.15 0.30 0.45], num_data(1:4,3),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter(0.2, num_data(5,3),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter(0.9, num_data([3,4],4),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter([0.75 0.9 1.05], num_data([1,2,5],4),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter([1.85 2.15], num_data([2,3],1),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter([1.85 2.15], num_data([1,4],1),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter([2.55 2.7 2.85], num_data([1,2,4],2),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter(2.7, num_data(3,2),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter(3.8, num_data(:,5),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter(4.5, num_data(:,6),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter(5.6, num_data([1,3,6],7),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter([5.45 5.6 5.75], num_data([2,4,5],7),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter([6.15, 6.45], num_data([1,2],8),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter([6.15, 6.45], num_data([4,6],8),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter(6.3, num_data([3,5],8),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter(7.4, num_data([2,4,5],9),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter([7.25, 7.55], num_data([1,3],9),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter([7.95, 8.25], num_data([2,3],10),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
scatter(8.1, num_data([1,4,5],10),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')

scatter(9.2, num_data(:,11),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')


scatter(9.9, num_data(:,12),10, 'MarkerEdgeColor','k', 'MarkerFaceColor','w')
set ( gca , 'FontSize' , 8 , 'fontname' , 'Arial','FontWeight', 'bold');

text(6.1,20, '##')

legend('Prestimulation', 'Stimulation','', 'No stim ctrl','Position', [0.8, 0.89, 0.1, 0.1])
xticks([0.5, 2.3, 4.3,6,7.8,9.6])
yticks([10 15 20])
xlim([-0.5 10.7])
ylim([7 22])
txt={'Ctrl', 'Ctrl Virus', '2 Hz', '5 Hz', '10 Hz', '20 Hz'};
xticklabels(txt)
ylabel('LH IPI (min)')

saveas(f,'figure6.svg','svg')
saveas(f,'figure6.eps','eps')


















