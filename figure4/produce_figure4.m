% Script to produce figure 4 
clearvars; clc;

addpath('cli_and_cil')
load('cli_cil_heatmap.mat')
load("colour.mat")
load('rainbow_cmap.mat')

% Hopf curves
load('HB1.dat')
load('HB2.dat')
% limit points
load('LP1v1.dat')

% homoclinic bifurcation
load('HOM1.dat')
load('HOM2.dat')
load('HOM3.dat')
load('HOM4.dat')

% 1 par 
load('EQ.dat')
load('PO.dat')

% Identify the stability of equilibria
Stable=zeros(length(EQ),4);
Unstable=zeros(length(EQ),4);

for i =1:length(EQ)
    Stable(i,1)=EQ(i,1);
    Unstable(i,1)=EQ(i,1);

    if EQ(i,6) ==3
        Stable(i,2) = EQ(i,3);
        Stable(i,3) = EQ(i,4);
        Stable(i,4) = EQ(i,5);
        Unstable(i,2) = NaN;
        Unstable(i,3) = NaN;
        Unstable(i,4) = NaN;

    else  
        Unstable(i,2) = EQ(i,3);
        Unstable(i,3) = EQ(i,4);
        Unstable(i,4) = EQ(i,5);
        Stable(i,2) = NaN;
        Stable(i,3) = NaN;
        Stable(i,4) = NaN;

    end
end

% Find vifurcation points

LP = NaN(2,4);
HB = NaN(1,4);

for i=1:length(EQ)-1

     if EQ(i+1,6)==1 && EQ(i,6)==2
        LP(1,1)=EQ(i,1);
        LP(1,2)=EQ(i,3);
        LP(1,3)=EQ(i,4);
        LP(1,4)=EQ(i,5);
     else
     end
     if EQ(i+1,6)==2 && EQ(i,6)==3
        LP(2,1)=EQ(i,1);
        LP(2,2)=EQ(i,3);
        LP(2,3)=EQ(i,4);
        LP(2,4)=EQ(i,5);
    else
    end
    
end

for i=1:length(EQ)-1

    if EQ(i+1,6)==1 && EQ(i,6)==3
        HB(1,1)=EQ(i,1);
        HB(1,2)=EQ(i,3);
        HB(1,3)=EQ(i,4);
        HB(1,4)=EQ(i,5);
    else
    end
    if EQ(i+1,6)==3 && EQ(i,6)==1
        HB(2,1)=EQ(i,1);
        HB(2,2)=EQ(i,3);
        HB(2,3)=EQ(i,4);
        HB(2,4)=EQ(i,5);
    else
    end
end

% Plot
f=figure(2); clf
f.Units="centimeters";
f.InnerPosition = [5 5 22 18];

axes ('Units', 'centimeters','Position',[1.5 13 4 4])
hold on; box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'FontWeight','bold');
% Equilibria
plot(Stable(:,1), Stable(:,2), 'Color','k','LineStyle','-','LineWidth',1.5)
plot(Unstable(:,1), Unstable(:,2), 'Color','k','LineStyle','--','LineWidth',1.5)
plot(PO(:,1),PO(:,3),'Color',colour.red,'LineWidth',1.5)
% Plot fixed points
plot(LP(:,1),LP(:,2),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
plot(HB(2,1), HB(2,2),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
plot(PO(end,1),PO(end,3),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)

text(HB(2,1),HB(2,2), ' HB', 'FontSize', 9, 'VerticalAlignment','bottom', 'FontWeight','bold');
text(PO(end,1),PO(end,3), ' HC', 'FontSize', 9, 'HorizontalAlignment','left', 'FontWeight','bold');
text(LP(:,1)+0.8,LP(:,2)-0.03, ' SN ', 'FontSize', 9, 'HorizontalAlignment','right', 'FontWeight','bold');

xlim([0 40])
ylim([-0.01 0.51])
xlabel('GABA_{int} \rightarrow Glu')
ylabel('Glu population activity')
%%
axes ('Units', 'centimeters','Position',[1.5 1.4 8 9.6])
hold on; box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'FontWeight','bold');
pluto = (out.put(:,:,1)'-out.put(:,:,2)');
image( A , B , pluto,'CDataMapping','scaled')
clim([-max(abs(pluto(:))), max(abs(pluto(:)))]);
rainbowColormap((length(rainbowColormap)+1)/2,:) = [1;1;1];
colormap(gca, flip(rainbowColormap));
bar = colorbar;
bar.Label.String = 'Mean MePD output';
bar.FontSize = 10;
bar.Location='southoutside';

plot(HB1(:,1), HB1(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)
plot(HB2(:,1), HB2(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)

plot(LP1v1(:,1), LP1v1(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)

plot(HOM1(:,1), HOM1(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM2(:,1), HOM2(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM3(:,1), HOM3(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM4(:,1), HOM4(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)

plot(LP1v1(3138,1), LP1v1(3138,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)
plot(HB1(end,1),HB1(end,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)
plot(HB2(end,1),HB2(end,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)

plot(35,16,'*','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)

text(37,20, 'HB', 'FontSize', 9, 'FontWeight','bold')
text(37,5, 'HB', 'FontSize', 9, 'FontWeight','bold')

text(3.5,39, 'SN', 'FontSize', 9, 'FontWeight','bold')
text(10,39, 'SN', 'FontSize', 9, 'FontWeight','bold')

text(7,18, 'HC', 'FontSize', 9, 'FontWeight','bold')
rectangle('Position', [0, 0, 40,40], 'EdgeColor', 'k', 'LineWidth', 0.8);
text(LP1v1(3138,1)-1, LP1v1(3138,6), 'CP', 'FontSize', 9, 'FontWeight','bold','VerticalAlignment','top')
text(HB1(end,1),HB1(end,6), 'BT ', 'FontSize', 9, 'FontWeight','bold','HorizontalAlignment','right')
text(HB2(end,1),HB2(end,6), 'BT ', 'FontSize', 9, 'FontWeight','bold','HorizontalAlignment','right')


ylim([0 40])
xlim([0 40])
xlabel('GABA_{int} \rightarrow Glu')
ylabel('Glu \rightarrow GABA_{int}')

% Repeat the same for the c_{li} x c_{ll}

rmpath('cli_and_cil')
addpath('cli_cll_parameters\')
load('cli_cll_heatmap.mat')
load('HB1.dat')
load('HB2.dat')
load('EQ.dat')
load('PO.dat')

Stable=zeros(length(EQ),4);
Unstable=zeros(length(EQ),4);

for i =1:length(EQ)
    Stable(i,1)=EQ(i,1);
    Unstable(i,1)=EQ(i,1);

    if EQ(i,6) ==3
        Stable(i,2) = EQ(i,3);
        Stable(i,3) = EQ(i,4);
        Stable(i,4) = EQ(i,5);
        Unstable(i,2) = NaN;
        Unstable(i,3) = NaN;
        Unstable(i,4) = NaN;

    else  
        Unstable(i,2) = EQ(i,3);
        Unstable(i,3) = EQ(i,4);
        Unstable(i,4) = EQ(i,5);
        Stable(i,2) = NaN;
        Stable(i,3) = NaN;
        Stable(i,4) = NaN;

    end
end


HB = NaN(1,4);


for i=1:length(EQ)-1

    if EQ(i+1,6)==1 && EQ(i,6)==3
        HB(1,1)=EQ(i,1);
        HB(1,2)=EQ(i,3);
        HB(1,3)=EQ(i,4);
        HB(1,4)=EQ(i,5);
    else
    end
    if EQ(i+1,6)==3 && EQ(i,6)==1
        HB(2,1)=EQ(i,1);
        HB(2,2)=EQ(i,3);
        HB(2,3)=EQ(i,4);
        HB(2,4)=EQ(i,5);
    else
    end
end

axes ('Units', 'centimeters','Position',[12 13 4 4])
hold on; box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'FontWeight','bold');

plot(Stable(:,1), Stable(:,2), 'Color','k','LineStyle','-','LineWidth',1.5)
plot(Unstable(:,1), Unstable(:,2), 'Color','k','LineStyle','--','LineWidth',1.5)
plot(PO(:,1),PO(:,3),'Color',colour.red,'LineWidth',1.5)
% plot fixed points

plot(HB(:,1), HB(:,2),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
text(HB(:,1),HB(:,2), 'HB ', 'FontSize', 9, 'FontWeight','bold','HorizontalAlignment','right')

xlim([0 40])
ylim([-0.01 0.51])
xlabel('Glu \rightarrow GABA_{int}')
ylabel('Glu population activity')

ax1=axes ('Units', 'centimeters','Position',[12 1.5 8 9.5]);
hold on;  box on;grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'FontWeight','bold');
pluto = (out.put(:,:,1)-out.put(:,:,2));
image( A , B , pluto,'CDataMapping','scaled')
clim([-max(abs(pluto(:))), max(abs(pluto(:)))]);
rainbowColormap((length(rainbowColormap)+1)/2,:) = [1;1;1];
colormap(gca, flip(rainbowColormap));
bar = colorbar;
bar.Label.String = 'Mean MePD output';
bar.FontSize = 10;
bar.Location='southoutside';
rectangle('Position', [0, 0, 40,40], 'EdgeColor', 'k', 'LineWidth', 0.8);
plot(HB1(:,1), HB1(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)
plot(HB2(:,1), HB2(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)


text(38,7, 'HB ', 'FontSize', 9, 'FontWeight','bold','HorizontalAlignment','right')

plot(18,16,'*','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)


ylim([0 40])
xlim([0 40])
xlabel('Glu \rightarrow Glu')
ylabel('Glu \rightarrow GABA_{int}')

saveas(f,'parameters.svg', 'svg')
