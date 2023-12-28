clearvars; clc;
addpath("C:/Users/kn356/OneDrive - University of Exeter/Desktop/StandardMATLAB")
load("rainbow_cmap.mat")
load("par.mat")
par.d=0.05;
time_vector = 0:0.1:5e+3;
%%
p1 = [1.6 , 14];
p2 = [0, 65];
n = 150;
% Define the parameter space
A = linspace(p1(1), p1(2),n);
B = linspace(p2(1), p2(2),n);
opts = odeset('RelTol',1e-6,'AbsTol',1e-8);
IC = zeros(6,1);

% loop over the parameter space
for i =1:length(A)
    for j = 1:length(B)
        par.Kp = A(i);
        par.cie = B(j);
        sol=ode45(@MePD_sys,time_vector,IC,opts, par);
        newIC = sol.y(:,end);
        newIC(4:6,1)=0;
        [~, Y1]=ode45(@MePD_sys,time_vector,[sol.y(:,end)],opts, par);
        out.put1(i,j,1)=Y1(end,4)./time_vector(end);
        out.put1(i,j,2)=Y1(end,6)./time_vector(end);
    end
end

%%
save("output", "out", "A", "B")
%%
load("output.mat")
f=figure(1); clf;
f.Units="centimeters";
f.OuterPosition = [5 5 18 18];


axes ('Units', 'centimeters','Position',[1.5 8 6.5 7])
hold on; box on; grid off
set ( gca , 'FontSize' , 9.5 , 'fontname' ,  'Arial', 'fontweight', 'bold');

v = [0 0.01];
ylim([0 45])
xlim([1.6 14])
h=1e-2;
pluto =   out.put1(:,:,1);
pluto = pluto';

image( A , B , pluto,'CDataMapping','scaled')
clim([0, max(abs(out.put1(:)))]);
colormap(gca, "jet");
title('a')
plot([0 14], [20 20], 'Color','k','LineStyle',':','LineWidth',2)
xlabel('Excitatory input')
ylabel('GABA_{int} \rightarrow GABA_{eff}')
bar = colorbar('southoutside');
bar.FontSize = 9.5;
bar.Label.String = 'Mean Glutamate Output';
hold off

axes ('Units', 'centimeters','Position',[10 8 6.5 7])
hold on; box on; grid off
set ( gca , 'FontSize' , 9.5 , 'fontname' ,  'Arial', 'fontweight', 'bold');

v = [0 0.01];
ylim([0 45])
xlim([1.6 14])
h=1e-2;

% pluto = out.sign(:,:)';
pluto =   out.put1(:,:,2);
pluto = pluto';

image( A , B , pluto,'CDataMapping','scaled')
colormap(gca, turbo);

colormap(gca, "jet");
plot([0 14], [20 20], 'Color','k','LineStyle',':','LineWidth',2)
xlabel('Excitatory input')
ylabel('GABA_{int} \rightarrow GABA_{eff}')
title('b')
bar = colorbar('southoutside');
bar.Label.String = 'Mean GABAergic Output';
bar.FontSize = 9.5;
pluto =  out.put1(:,:,2);
clim([0, max(abs(out.put1(:)))]);


axes ('Units', 'centimeters','Position',[5.5 0.2 6.5 7])
hold on; box on; grid off
set ( gca , 'FontSize' , 9.5 , 'fontname' ,  'Arial', 'fontweight', 'bold');

v = [0 0.01];
ylim([0 45])
xlim([1.6 14])
h=1e-2;

pluto =  out.put1(:,:,1)-out.put1(:,:,2);
pluto = pluto';
rainbowColormap2=rainbowColormap;
rainbowColormap2((length(rainbowColormap2)-1)/2,:)=[1,1,1];
image( A , B , pluto,'CDataMapping','scaled')
colormap(gca, turbo);
clim([-max(abs(pluto(:))), max(abs(pluto(:)))]);
plot([0 14], [20 20], 'Color','k','LineStyle',':','LineWidth',2)
colormap(gca, flip(rainbowColormap2));

xlabel('Excitatory input')
ylabel('GABA_{int} \rightarrow GABA_{eff}')
title('c')
bar = colorbar('southoutside');
bar.Label.String = 'Mean MePD Output';
bar.FontSize = 9.5;
saveas(f,'out.svg', 'svg')