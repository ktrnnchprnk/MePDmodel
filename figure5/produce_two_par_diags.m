clc; clearvars
%%
load("rainbow_cmap.mat")
load("colour.mat")

%%
addpath("2parGABA")
load("HB1.dat")
load("HB2.dat")
load("LP1v1.dat")
load("LP2v1.dat")
load("LP2v2.dat")

load("HOM1.dat")
load("HOM2.dat")
load("HOM3.dat")
load("HOM4.dat")
load("HOM5.dat")


close all




close all
f1=figure(1);
f1.Units="centimeters";
% f.InnerPosition = [2 2 17 7];
f1.OuterPosition = [2 2 8 10.5];


hold on; box on; grid off
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
ylim([0 1])
xlim([-1 22])

load("Kp_beta1_heatmap.mat")
pluto = (out.put(:,:,1)'-out.put(:,:,2)');
image( A , B , pluto,'CDataMapping','scaled')
clim([-max(abs(pluto(:))), max(abs(pluto(:)))]);
rainbowColormap(1,:) = [];
rainbowColormap((length(rainbowColormap))/2,:) = [1;1;1];
colormap(gca, flip(rainbowColormap));
bar = colorbar;
bar.Label.String = 'Mean MePD output';
bar.FontSize = 9.5;
bar.Location='southoutside';
plot(LP1v1(:,1), LP1v1(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(HB1(:,1), HB1(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)
% plot(HOM1(:,1), HOM1(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
% plot(LP1v2(:,1), LP1v2(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(LP2v1(:,1), LP2v1(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(LP2v2(:,1), LP2v2(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
rectangle('Position', [0, 0, 7,1], 'EdgeColor', 'k', 'LineWidth', 0.8);
plot(HB2(:,1), HB2(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)

% plot(HOM1(:,1), HOM1(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
% plot(HOM2(:,1), HOM2(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM3(:,1), HOM3(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM4(:,1), HOM4(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
% plot(HOM5(:,1), HOM5(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
% plot(HOM6(:,1), HOM6(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
text(2.3,0.5, 'd', 'FontSize', 9.5,'FontWeight','bold');
text(6,0.5, 'e', 'FontSize', 9.5,'FontWeight','bold');

xlim([0 7])
% xticks([0 2 4 6 8  10 12 14])
xlabel('MePD excitatory input')
ylabel('$\beta_{1}$','Interpreter','latex')
% title('a')
hold off

saveas(f1, 'GABAsupp.svg', 'svg')

rmpath("2parGABA\")
addpath("2parGlut\")
load("HB1.dat")
load("LP1v1.dat")




addpath("2parGABA")
load("HB1.dat")
load("HB2.dat")
load("LP1v1.dat")
load("LP2v1.dat")
load("LP2v2.dat")
load("HOM1.dat")
load("HOM2.dat")
load("HOM3.dat")
load("HOM4.dat")
load("HOM5.dat")

f2=figure(2);
f2.Units="centimeters";

f2.OuterPosition = [2 2 8 10.5];

hold on; box on; grid off
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
ylim([0 1])
xlim([-1 12])
rmpath("2parGABA\")
addpath("2parGlut\")
load("HB1.dat")
load("LP1v1.dat")
load("beta2_Kp_heatmap.mat")
pluto = (out.put(:,:,1)'-out.put(:,:,2)');
image( A , B , pluto,'CDataMapping','scaled')
clim([-max(abs(pluto(:))), max(abs(pluto(:)))]);

rainbowColormap(1,:) = [];
rainbowColormap((length(rainbowColormap)+1)/2,:) = [1;1;1];

colormap(gca, flip(rainbowColormap));
bar = colorbar;
bar.FontSize = 9.5;
bar.Label.String = 'Mean MePD output';
bar.Location='southoutside';
rectangle('Position', [0, 0, 7,1], 'EdgeColor', 'k', 'LineWidth', 0.8);
plot(LP1v1(:,1), LP1v1(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(HB1(:,1), HB1(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)

text(2.3,0.5, 'g', 'FontSize', 9.5,'FontWeight','bold');
text(6,0.5, 'h', 'FontSize', 9.5,'FontWeight','bold');

xlim([0 7])
xticks([0 1 2 3 4 5 6 7 8  10 12 14])
xlabel('MePD excitatory input')
ylabel('$\beta_{2}$','Interpreter','latex')
saveas(f2,'Glutsupp.svg', 'svg')

rmpath("2parGlut\")
addpath("2parGABA\")
load("HB1.dat")
load("HB2.dat")
load("LP1v1.dat")
load("LP2v1.dat")
load("LP2v2.dat")
load("HOM1.dat")
load("HOM2.dat")
load("HOM3.dat")
load("HOM4.dat")
load("HOM5.dat")


f=figure(3);
f.Units="centimeters";
% f.InnerPosition = [2 2 17 7];
f.OuterPosition = [2 2 12 20];

subplot(2,1,1)
hold on; box on; grid off
set ( gca , 'FontSize' , 10 , 'fontname' , 'Arial', 'fontweight', 'bold');
ylim([0 1])
xlim([-1 22])

plot(LP1v1(:,1), LP1v1(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(HB1(:,1), HB1(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)
plot(HOM1(:,1), HOM1(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(LP2v1(:,1), LP2v1(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(LP2v2(:,1), LP2v2(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)

plot(HB2(:,1), HB2(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)

plot(HOM1(:,1), HOM1(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM2(:,1), HOM2(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM3(:,1), HOM3(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM4(:,1), HOM4(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM5(:,1), HOM5(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)

plot(HB1(end,1),HB1(end,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)
plot(HB2(end,1),HB2(end,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)

plot(LP1v1(1895,1),LP1v1(1895,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)
plot(LP1v1(2148,1),LP1v1(2148,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)

text(LP1v1(1895,1),LP1v1(1895,6)+0.05, 'CP', 'FontSize', 10,'FontWeight','bold');
text(LP1v1(2148,1),LP1v1(2148,6), 'CP ', 'FontSize', 10,'FontWeight','bold','HorizontalAlignment','right');
text(HB1(end,1),HB1(end,6), 'BT ', 'FontSize', 10,'FontWeight','bold','HorizontalAlignment','right');
% text(5.5,0.5, 'g', 'FontSize', 12,'FontWeight','bold');
% text(2.5,0.1, 'Oscillatory Region', 'FontSize', 9,'FontWeight','bold');

legend('SN', 'HB', 'HC')
h = legend;
set(h, 'FontSize', 10);
xticks([0 2 4 6 8 10 12])
xlim([0 12])
xlabel('MePD excitatory input')
ylabel('GABA suppression')
title('a')
hold off

rmpath("2parGABA\")
addpath("2parGlut\")
load("HB1.dat")
load("LP1v1.dat")

subplot(2,1,2)

hold on; box on; grid off
set ( gca , 'FontSize' , 10 , 'fontname' , 'Arial', 'fontweight', 'bold');
ylim([0 1])
xlim([-1 12])


plot(LP1v1(:,1), LP1v1(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(HB1(:,1), HB1(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)


% plot(LP1v1(19,1),LP1v1(19,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)
% text(2.25,0.5, 'e', 'FontSize', 12,'FontWeight','bold');
% text(5.5,0.5, 'h', 'FontSize', 12,'FontWeight','bold');
% text(1.95,0.1, 'Oscillatory Region', 'FontSize', 9,'FontWeight','bold');

legend('','HB')
h = legend;
set(h, 'FontSize', 10);
xticks([0 1 2 3 4 5 6 7 8  10 12 14])
xlabel('MePD excitatory input')
ylabel('Glutamate suppression')
title('b')
saveas(f,'out1.svg', 'svg')


