% Code to produce figure 2 
clearvars
close all
load('rainbow_cmap.mat')
load("colour.mat")

%% Load AUTO files 
load('KpLCr1.dat')
load('KpLCr2.dat')

% Hopf bifurcations
load('HB1.dat')
load('HB2.dat')
% limit points
load('LP1v1.dat')

% homoclinic bifurcation
load('HOM1.dat')
load('HOM2.dat')

% load heatmap 
load("Kp_alpha1.mat")
Stable=zeros(length(KpLCr1),4);
Unstable=zeros(length(KpLCr1),4);

% Identify stability based on the analysis
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

% Find the location of special points
LP = zeros(length(KpLCr1)-1,4);
HB = zeros(1,4);


LP(LP==0) = NaN;
rows_with_nan = any(isnan(LP), 2);
LP = LP(~rows_with_nan, :);
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
f.OuterPosition = [5 5 18 23];

% diagram for Glu
axes ('Units', 'centimeters','Position',[1.5 12.5 4 7])
hold on;  box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold', 'fontweight', 'bold');
plot(Stable(:,1), Stable(:,2), 'Color','k','LineStyle','-','LineWidth',1.5)
plot(Unstable(:,1), Unstable(:,2), 'Color','k','LineStyle','--','LineWidth',1.5)
plot(KpLCr2(:,1),KpLCr2(:,3),'Color',colour.red,'LineWidth',1.5)
Base=2.3;
Stim=6;
T1 = find(round(KpLCr2(:,1),1)==Base,1);
T2 = find(round(KpLCr2(:,1),1)==Stim,1);
plot(KpLCr2(T1,1),KpLCr2(T1,3),'^','MarkerFaceColor',colour.yellow,'MarkerEdgeColor',colour.yellow, 'MarkerSize', 4,'LineWidth',1.5)
plot(KpLCr2(T2,1),KpLCr2(T2,3),'^','MarkerFaceColor',colour.blue,'MarkerEdgeColor',colour.blue, 'MarkerSize', 4,'LineWidth',1.5)
plot(HB(:,1), HB(:,2),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
text(HB(1,1),HB(1,2)-0.01, ' HB', 'FontSize', 9, 'fontweight', 'bold', 'HorizontalAlignment', 'left');
yticks([0 0.1 0.2 0.3 0.4 0.5])
xlim([0 14])
ylim([-0.01 0.51])
xlabel('MePD excitation')
ylabel('Glu population activity')
xticks([0 2 6 10 14 18 23])
title('a')

% diagram for GABA_int
axes ('Units', 'centimeters','Position',[7 12.5 4 7])
hold on;  box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold', 'fontweight', 'bold');
plot(Stable(:,1), Stable(:,3), 'Color','k','LineStyle','-','LineWidth',1.5)
plot(Unstable(:,1), Unstable(:,3), 'Color','k','LineStyle','--','LineWidth',1.5)
plot(KpLCr2(:,1),KpLCr2(:,4),'Color',colour.red,'LineWidth',1.5)
plot(KpLCr2(T1,1),KpLCr2(T1,4),'^','MarkerFaceColor',colour.yellow,'MarkerEdgeColor',colour.yellow, 'MarkerSize', 4,'LineWidth',1.5)
plot(KpLCr2(T2,1),KpLCr2(T2,4),'^','MarkerFaceColor',colour.blue,'MarkerEdgeColor',colour.blue, 'MarkerSize', 4,'LineWidth',1.5)
plot(HB(:,1), HB(:,3),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
text(HB(1,1),HB(1,3), ' HB', 'FontSize', 9, 'fontweight', 'bold', 'HorizontalAlignment', 'left');
yticks([0 0.1 0.2 0.3 0.4 0.5])
xticks([0 2 6 10 14])
xlim([0 14])
ylim([-0.01 0.51 ])
xlabel('MePD excitation')
ylabel('GABA_{int} population activity')
title('b')
hold off

% diagram for GABA_eff
axes ('Units', 'centimeters','Position',[12.5 12.5 4 7])
hold on;  box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold', 'fontweight', 'bold');
plot(Stable(:,1), Stable(:,4), 'Color','k','LineStyle','-','LineWidth',1.5)
plot(Unstable(:,1), Unstable(:,4), 'Color','k','LineStyle','--','LineWidth',1.5)
plot(KpLCr2(:,1),KpLCr2(:,5),'Color',colour.red,'LineWidth',1.5)
plot(KpLCr2(T1,1),KpLCr2(T1,5),'^','MarkerFaceColor',colour.yellow,'MarkerEdgeColor',colour.yellow, 'MarkerSize', 4,'LineWidth',1.5)
plot(KpLCr2(T2,1),KpLCr2(T2,5),'^','MarkerFaceColor',colour.blue,'MarkerEdgeColor',colour.blue, 'MarkerSize', 4,'LineWidth',1.5)
plot(HB(:,1), HB(:,4),'o','MarkerFaceColor','k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',1.5)
text(HB(1,1),HB(1,4)-0.01, ' HB', 'FontSize', 9, 'fontweight', 'bold', 'HorizontalAlignment', 'left');
yticks([0 0.1 0.2 0.3 0.4 0.5])
xlim([0 14])
ylim([-0.01 0.51])
xticks([0 2 6 10 14 18 22])
xlabel('MePD excitation')
ylabel('GABA_{eff} population activity')
title('c')

X0 = zeros(1,6);
opts = odeset('RelTol',1e-8,'AbsTol',1e-11);
Tinit=0;
Tmax=300;
Dt =0.001;

% Simulate the system

load("par.mat")
par.d=3/60;
Tspan = Tinit:Dt:Tmax;
par.Kp=Base;
[~,Y]=ode45(@MePD_sys,Tspan,X0,opts, par);
[T,Y]=ode45(@MePD_sys,Tspan,Y(end,:),opts, par);

x = Y(:,1); % simulation data
[~, locs] = findpeaks(x, 'MinPeakProminence',0.1);
Freq1 = (1/mean(diff(locs)*Dt));

par.Kp=Stim;
[~,Y1]=ode45(@MePD_sys,Tspan,X0,opts, par);
[T,Y1]=ode45(@MePD_sys,Tspan,Y1(end,:),opts, par);



% system's simulation at K_p = 2.3 for output variables
axes ('Units', 'centimeters','Position',[1.5 7.2 4 3.5])
hold on;  box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y(:,1),'Color',colour.green,'LineStyle','-','LineWidth',1.5 )
plot(T, Y(:,3),'Color',colour.red,'LineStyle','-','LineWidth',1.5 )

plot(15,0.45,'^','MarkerFaceColor',colour.yellow,'MarkerEdgeColor',colour.yellow, 'MarkerSize', 4,'LineWidth',1.5)

ylabel('Averaged Activity','fontname' , 'Arial', 'fontweight', 'bold')
xlabel('Time (s)','fontname' , 'Arial', 'fontweight', 'bold')
ylim([0 .5])
xlim([0 Tmax])

title('d')
hold off

% Plot oscillations period
axes ('Units', 'centimeters','Position',[12.5 7.2 4 3.5]);
hold on;  box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(KpLCr2(:,1),KpLCr2(:,6)*60, 'Color','k','LineStyle','-','LineWidth',1.5) % multiply by 60 to convert period in seconds
xlabel('MePD excitation')
xlim([0.75 14])
ylim([1 120])
ylabel('        Period (s)')
title('f')
hold off 

% % oscillations orbit at K_p = 6
axes ('Units', 'centimeters','Position',[7 7.2 4 3.5])
hold on; box on; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,1),'Color',colour.green,'LineStyle','-','LineWidth',1.5 )
plot(T, Y1(:,3),'Color',colour.red,'LineStyle','-','LineWidth',1.5 )
plot(15,0.45,'^','MarkerFaceColor',colour.blue,'MarkerEdgeColor',colour.blue, 'MarkerSize', 4,'LineWidth',1.5)
ylabel('Averaged Activity','fontname' , 'Arial', 'fontweight', 'bold')
xlabel('Time (s)','fontname' , 'Arial', 'fontweight', 'bold')
legend('Glu', 'GABA_{eff}')
ylim([0 .5])
xlim([0 Tmax])
title('e')

% Plot 2-par bifurcation of Kp and alpha
axes ('Units', 'centimeters','Position',[1.5 1 15.5 4])
hold on;  box on; grid off;
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'FontWeight', 'bold');
pluto = (out.put(:,:,1)'-out.put(:,:,2)');
image( A , B , pluto,'CDataMapping','scaled')
clim([-max(abs(pluto(:))), max(abs(pluto(:)))]);
colormap(gca, (rainbowColormap));
bar = colorbar;
bar.Label.String = 'Mean MePD output';
bar.Location='eastoutside';
bar.FontSize = 9.5;
plot(HB1(:,1), HB1(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)
plot(HB2(:,1), HB2(:,6), 'Color',colour.red,'LineStyle','-','LineWidth',1.5)
plot(LP1v1(:,1), LP1v1(:,6), 'Color',colour.green,'LineStyle','-','LineWidth',1.5)
plot(HOM1(:,1), HOM1(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
plot(HOM2(:,1), HOM2(:,6), 'Color',colour.purple,'LineStyle','-','LineWidth',1.5)
% location of special points
plot(HB1(end,1),HB1(end,6),'o','MarkerFaceColor', 'k','MarkerEdgeColor','black', 'MarkerSize', 4,'LineWidth',0.7)
text(HB1(end,1),HB1(end,6), 'BT', 'FontSize', 9, 'FontWeight','bold','VerticalAlignment','bottom');
text(3,0.77, 'HB', 'FontSize', 9, 'FontWeight','bold')
text(18,0.92, 'SN', 'FontSize', 9, 'FontWeight','bold')
text(18,0.77, 'SN', 'FontSize', 9, 'FontWeight','bold')
text(16,0.935, 'HC', 'FontSize', 9, 'FontWeight','bold')
rectangle('Position', [0, 0.7, 20.5,0.3], 'EdgeColor', 'k', 'LineWidth', 0.8);
ylim([0.7 1.0])
xlim([0 20.5])
xlabel('MePD excitation')
ylabel('Relative Glu excitation ratio')
title('g')
saveas(f,'fig2.svg', 'svg')