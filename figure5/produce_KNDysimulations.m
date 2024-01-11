% Produce simulations of the coupled model 
clc; clearvars

addpath("C:/Users/kn356/OneDrive - University of Exeter/Desktop/StandardMATLAB")
load('colour.mat')
load('rainbow_cmap.mat')
addpath("C:/Users/kn356/OneDrive - University of Exeter/Desktop/StandardMATLAB/KNDy_coupled")
load("par.mat")
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);
%%

Control = 2.3;
Stim = 6;

Antagonist1 = 0.5;
Antagonist2 = 0.5;

Tinit=0;
Tmax=65;
Dt =0.001;
Tspan = Tinit:Dt:Tmax;
Tspan1 = Tinit:Dt:260;

par.d=3; 
X0 = zeros(6,1);

%% Control (plotting torus) 
par.Kp = Control; 
par.beta1  = 0;
par.beta2  = 0;

[~, Y]=ode45(@KNDy,Tspan1,X0,opts, par);
[T, Y1]=ode45(@KNDy,Tspan,Y(end,:),opts, par);

x1 = Y1(:,6)/60;
[~, locs1] = findpeaks(x1, 'MinPeakProminence',10);
PeriodMain(1) = mean(diff(locs1)*Dt);

ColoredOut1(:,1) = T(locs1(2):locs1(3));
ColoredOut1(:,2) = Y1(locs1(2):locs1(3),6); % KNDy
ColoredOut1(:,3) = Y1(locs1(2):locs1(3),4); % 
ColoredOut1(:,4) = Y1(locs1(2):locs1(3),5); %
ColoredOut1(:,5) = Y1(locs1(2):locs1(3),1); % glut
ColoredOut1(:,6) = Y1(locs1(2):locs1(3),3); % GABA

colormap('jet')

normalized_time = (ColoredOut1(:,1) - min(ColoredOut1(:,1))) / (max(ColoredOut1(:,1)) - min(ColoredOut1(:,1)));
colors = colormap;
color_idx = round(normalized_time * (size(colors, 1) - 1)) + 1;
color_vector = colors(color_idx, :);

f11=figure(11); clf
f11.Units="centimeters";
f11.OuterPosition = [0.1 4 30 24];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 32 , 'fontname' , 'Arial', 'fontweight', 'bold');
scatter3(ColoredOut1(:,5), ColoredOut1(:,6),log(ColoredOut1(:,2)/60),8, color_vector(:, :),'o', 'filled');


view(220, 20)
hold off
exportgraphics(f11,'sphere.pdf')

%% Stim

par.Kp = Stim; 
par.beta1  = 0;
par.beta2  = 0;

[T, Y2]=ode45(@KNDy,Tspan,Y1(end,:),opts, par);


x1 = Y2(:,6)/60;
[~, locs] = findpeaks(x1, 'MinPeakProminence',10);
PeriodMain(2) = mean(diff(locs)*Dt);


f1=figure(1); clf
f1.Units="centimeters";
f1.OuterPosition = [0.1 4 9 7];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T(1:locs1(2)), Y1(1:locs1(2),6)/60, 'LineWidth', 1, 'Color','k')
plot(T(locs1(3):end), Y1(locs1(3):end,6)/60, 'LineWidth', 1, 'Color','k')
plot(T+Tmax, Y2(:,6)/60, 'LineWidth', 1, 'Color','k')
scatter(ColoredOut1(:,1),ColoredOut1(:,2)/60,1.5, color_vector(:, :),'o', 'filled');
ylabel('KNDy activity (Hz)')
xlabel('Time (min)')
  
ylim([-2 max(Y(:,6)/60)+5])
xlim([0 2*Tmax])
hold off


f2=figure(2); clf
f2.Units="centimeters";
f2.OuterPosition = [0.1 4 9 5.6];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T, Y1(:,3), 'LineWidth', 1, 'Color',colour.red)
plot(T+Tmax, Y2(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T+Tmax, Y2(:,3), 'LineWidth', 1, 'Color',colour.red)


ylabel('MePD out (Hz)')
xlabel('Time (min)')
  
ylim([0 0.55])
yticks([0 0.2 0.4])
xlim([55 75]) 
hold off

% GABA antagonist

par.Kp = Control; 
par.beta1  = Antagonist1;
par.beta2  = 0;

[T, Y3]=ode45(@KNDy,Tspan,Y1(end,:),opts, par);

x1 = Y3(:,6)/60;
[~, locs] = findpeaks(x1, 'MinPeakProminence',10);
PeriodMain(3) = mean(diff(locs)*Dt);

f3=figure(3); clf
f3.Units="centimeters";
f3.OuterPosition = [0.1 4 9 7];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,6)/60, 'LineWidth', 1, 'Color','k')
plot(T+Tmax, Y3(:,6)/60, 'LineWidth', 1, 'Color','k')

 
ylabel('KNDy activity (Hz)')
xlabel('Time (min)')
  
  
ylim([-2 max(Y(:,6)/60)+5])
xlim([0 2*Tmax])
hold off


f4=figure(4); clf
f4.Units="centimeters";
f4.OuterPosition = [0.1 4 9 5.6];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T, Y1(:,3), 'LineWidth', 1, 'Color',colour.red)
plot(T+Tmax, Y3(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T+Tmax, Y3(:,3), 'LineWidth', 1, 'Color',colour.red)


ylabel('MePD out (Hz)')
xlabel('Time (min)')
  
ylim([0 0.55])
yticks([0 0.2 0.4])
xlim([55 75]) 
hold off

% GABA antagonist + Stimulation

par.Kp = Stim; 
par.beta1  = Antagonist1;
par.beta2  = 0;

[T, Y4]=ode45(@KNDy,Tspan,Y1(end,:),opts, par);


x1 = Y4(:,6)/60;
[~, locs] = findpeaks(x1, 'MinPeakProminence',10);
PeriodMain(4) = mean(diff(locs)*Dt);

f5=figure(5); clf
f5.Units="centimeters";
f5.OuterPosition = [0.1 4 9 7];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,6)/60, 'LineWidth', 1, 'Color','k')
plot(T+Tmax, Y4(:,6)/60, 'LineWidth', 1, 'Color','k')

xlabel('Time (min)')
  
  
ylim([-2 max(Y(:,6)/60)+5])
xlim([0 2*Tmax])
hold off


f6=figure(6); clf
f6.Units="centimeters";
f6.OuterPosition = [0.1 4 9 5.6];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T, Y1(:,3), 'LineWidth', 1, 'Color',colour.red)
plot(T+Tmax, Y4(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T+Tmax, Y4(:,3), 'LineWidth', 1, 'Color',colour.red)


xlabel('Time (min)')
  
ylim([0 0.55])
yticks([0 0.2 0.4])
xlim([55 75]) 
hold off

% Glut antagonist 

par.Kp = Control; 
par.beta1  = 0;
par.beta2  = Antagonist2;

[T, Y5]=ode45(@KNDy,Tspan,Y1(end,:),opts, par);


x1 = Y5(:,6)/60;
[~, locs] = findpeaks(x1, 'MinPeakProminence',10);
PeriodMain(5) = mean(diff(locs)*Dt);

f7=figure(7); clf
f7.Units="centimeters";
f7.OuterPosition = [0.1 4 9 7];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,6)/60, 'LineWidth', 1, 'Color','k')
plot(T+Tmax, Y5(:,6)/60, 'LineWidth', 1, 'Color','k')

 
% 
ylabel('KNDy activity (Hz)')
xlabel('Time (min)')
  
  
ylim([-2 max(Y(:,6)/60)+5])
xlim([0 2*Tmax])
hold off


f8=figure(8); clf
f8.Units="centimeters";
f8.OuterPosition = [0.1 4 9 5.6];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T, Y1(:,3), 'LineWidth', 1, 'Color',colour.red)
plot(T+Tmax, Y5(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T+Tmax, Y5(:,3), 'LineWidth', 1, 'Color',colour.red)


ylabel('MePD out (Hz)')
xlabel('Time (min)')
  
ylim([0 0.55])
yticks([0 0.2 0.4])
xlim([55 75]) 
hold off

% Glut antagonist + stimulation

par.Kp = Stim; 
par.beta1  = 0;
par.beta2  = Antagonist2;

[T, Y6]=ode45(@KNDy,Tspan,Y1(end,:),opts, par);


x1 = Y6(:,6)/60;
[~, locs] = findpeaks(x1, 'MinPeakProminence',10);
PeriodMain(5) = mean(diff(locs)*Dt);

f9=figure(9); clf
f9.Units="centimeters";
f9.OuterPosition = [0.1 4 9 7];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,6)/60, 'LineWidth', 1, 'Color','k')
plot(T+Tmax, Y6(:,6)/60, 'LineWidth', 1, 'Color','k')

 
xlabel('Time (min)')
  
  
ylim([-2 max(Y(:,6)/60)+5])
xlim([0 2*Tmax])
hold off


f10=figure(10); clf
f10.Units="centimeters";
f10.OuterPosition = [0.1 4 9 5.6];
hold on; box on; grid off; 
set ( gca , 'FontSize' , 9.5 , 'fontname' , 'Arial', 'fontweight', 'bold');
plot(T, Y1(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T, Y1(:,3), 'LineWidth', 1, 'Color',colour.red)
plot(T+Tmax, Y6(:,1), 'LineWidth', 1, 'Color',colour.green)
plot(T+Tmax, Y6(:,3), 'LineWidth', 1, 'Color',colour.red)


xlabel('Time (min)')
  
ylim([0 0.55])
yticks([0 0.2 0.4])
xlim([55 75]) 
xlim([55 75]) 
hold off
% Save figures
saveas(f1,'KNDy_stim.svg', 'svg')
saveas(f2,'MePD_stim.svg', 'svg')
saveas(f3,'KNDy_GABA.svg', 'svg')
saveas(f4,'MePD_GABA.svg', 'svg')
saveas(f5,'KNDy_GABAstim.svg', 'svg')
saveas(f6,'MePD_GABAstim.svg', 'svg')
saveas(f7,'KNDy_glut.svg', 'svg')
saveas(f8,'MePD_glut.svg', 'svg')
saveas(f9,'KNDy_glutstim.svg', 'svg')
saveas(f10,'MePD_glutstim.svg', 'svg')