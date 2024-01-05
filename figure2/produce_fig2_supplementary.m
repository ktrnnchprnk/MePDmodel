% Code to produce supplementary figure to figure 2
clearvars
close all
load("colour.mat")

% load AUTO data

load('KpLCr1.dat')
load('KpLCr2.dat')

% identify the stability of equilibria
Stable=zeros(length(KpLCr1),4);
Unstable=zeros(length(KpLCr1),4);

for i =1:length(KpLCr1)
    Stable(i,1)=KpLCr1(i,1);
    Unstable(i,1)=KpLCr1(i,1);

    if KpLCr1(i,6) ==3
        Stable(i,2) = KpLCr1(i,3);
        Stable(i,3) = KpLCr1(i,4);
        Stable(i,4) = KpLCr1(i,5);
        Unstable(i,2) = NaN;
        Unstable(i,3) = NaN;
        Unstable(i,4) = NaN;

    else  
        Unstable(i,2) = KpLCr1(i,3);
        Unstable(i,3) = KpLCr1(i,4);
        Unstable(i,4) = KpLCr1(i,5);
        Stable(i,2) = NaN;
        Stable(i,3) = NaN;
        Stable(i,4) = NaN;

    end
end

% find special points

LP = NaN(2,4);
HB = zeros(1,4);

for i=1:length(KpLCr1)-1

     if KpLCr1(i+1,6)==2 && KpLCr1(i,6)==1
        LP(1,1)=KpLCr1(i,1);
        LP(1,2)=KpLCr1(i,3);
        LP(1,3)=KpLCr1(i,4);
        LP(1,4)=KpLCr1(i,5);
     else
     end
     if KpLCr1(i+1,6)==3 && KpLCr1(i,6)==2
        LP(2,1)=KpLCr1(i,1);
        LP(2,2)=KpLCr1(i,3);
        LP(2,3)=KpLCr1(i,4);
        LP(2,4)=KpLCr1(i,5);
    else
    end
    
end

for i=1:length(KpLCr1)-1

    if KpLCr1(i+1,6)==1 && KpLCr1(i,6)==3
        HB(1,1)=KpLCr1(i,1);
        HB(1,2)=KpLCr1(i,3);
        HB(1,3)=KpLCr1(i,4);
        HB(1,4)=KpLCr1(i,5);
    else
    end
    if KpLCr1(i+1,6)==3 && KpLCr1(i,6)==1
        HB(2,1)=KpLCr1(i,1);
        HB(2,2)=KpLCr1(i,3);
        HB(2,3)=KpLCr1(i,4);
        HB(2,4)=KpLCr1(i,5);
    else
    end
end

f=figure(1); clf;
f.Units="centimeters";
f.OuterPosition = [5 5 14.8 20];

% Plot diagram for Glu
subplot(3,2,[1,3]);
hold on;  box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(Stable(:,1), Stable(:,2), 'Color','k','LineStyle','-','LineWidth',1.5)
plot(Unstable(:,1), Unstable(:,2), 'Color','k','LineStyle','--','LineWidth',1.5)
plot(KpLCr2(:,1),KpLCr2(:,3),'Color',colour.red,'LineWidth',1.5)
plot(LP(:,1),LP(:,2),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
plot(HB(1,1), HB(1,2),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
plot(KpLCr2(end,1),KpLCr2(end,3),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
xlim([0 22])
ylim([-0.01 0.51])
xlabel('MePD excitation')
ylabel('Glu population activity')
title('a')
xticks([0 2 6 10 14 18 22])
text(HB(1,1),HB(1,2), ' HB', 'FontSize' , 9.5, 'HorizontalAlignment','left', 'FontWeight','bold');
text(KpLCr2(end,1),KpLCr2(end,3), ' HC', 'FontSize' , 9.5, 'HorizontalAlignment','left', 'FontWeight','bold');
text(LP(:,1),LP(:,2), ' SN', 'FontSize' , 9.5, 'HorizontalAlignment','left', 'FontWeight','bold');





% Plot diagram for GABA_eff
subplot(3,2,[2,4]);
hold on;  box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(Stable(:,1), Stable(:,4), 'Color','k','LineStyle','-','LineWidth',1.5)
plot(Unstable(:,1), Unstable(:,4), 'Color','k','LineStyle','--','LineWidth',1.5)
plot(KpLCr2(:,1),KpLCr2(:,5),'Color',colour.red,'LineWidth',1.5)
plot(HB(:,1),HB(:,4),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
plot(LP(:,1),LP(:,4),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
plot(KpLCr2(end,1),KpLCr2(end,5),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
xlim([0 22])
ylim([-0.01 0.51])
xticks([0 2 6 10 14 18 22])
xlabel('MePD excitation')
ylabel('GABA_{eff} population activity')
text(HB(1,1)+1,HB(1,4), ' HB', 'FontSize' , 9.5, 'HorizontalAlignment','left', 'Rotation',-90, 'FontWeight','bold');
text(KpLCr2(end,1),KpLCr2(end,5)+0.005, ' HC ', 'FontSize' , 9.5, 'HorizontalAlignment','right', 'FontWeight','bold');
text(LP(2,1),LP(2,4)-0.005, ' SN', 'FontSize' , 9.5, 'HorizontalAlignment','left', 'FontWeight','bold');
text(LP(1,1),LP(1,4)+0.005, ' SN', 'FontSize' , 9.5, 'HorizontalAlignment','left', 'FontWeight','bold');
title('b')
hold off


% Plot period 
axes ('Units', 'centimeters','Position',[4.5 1 6 4.5]);
hold on; box on; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(KpLCr2(:,1),log(KpLCr2(:,6)/0.05), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
xlabel('MePD excitation')
ylim([2 19])
ylabel('        log(Period (s))')
title('c')
hold off 


saveas(f,'fig2supp.svg', 'svg')