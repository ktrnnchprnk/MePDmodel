clearvars; clc;
addpath("C:/Users/kn356/OneDrive - University of Exeter/Desktop/StandardMATLAB")
load("colour.mat")
addpath("C:/Users/kn356/OneDrive - University of Exeter/Desktop/StandardMATLAB/MePD")
load("par.mat")
par.d=0.05;

p1 = [0 , 7];
p2 = [0, 1];
n = 150;
% Define the parameter space
A = linspace(p1(1), p1(2),n);
B = linspace(p2(1), p2(2),n);


time_vector = 0:0.5:5000;
opts = odeset('RelTol',1e-6,'AbsTol',1e-8);
out.amplitude=zeros(length(A), length(B));
out.put = zeros(length(A), length(B),2);
% out.frequency = zeros(length(A), length(B));


for i =1:length(A)
    for j = 1:length(B)
        display([i,j])
        par.Kp=A(i);
        par.beta2=B(j);
            IC = zeros(6,1);
            sol=ode45(@MePD_sys,time_vector,IC,opts, par);
            newIC = sol.y(:,end);
            newIC(4:6,1)=0;
            [T, Y]=ode45(@MePD_sys,time_vector,newIC,opts, par);
            out.amplitude(i,j) = max(Y(:,1))-min(Y(:,1));
            out.put(i,j,1) = Y(end,4)/time_vector(end);
            out.put(i,j,2) = Y(end,6)/time_vector(end);
    end
end
%%
save("beta2_Kp_heatmap.mat", "A", "B", "out")