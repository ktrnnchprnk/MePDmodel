% Script to find mean output from the MePD on 
% the Kp x \alpha parameter space
clearvars; clc;
load("par.mat")
par.d=0.05;

p1 = [0 , 22];
p2 = [0.7, 1];
n = 150;
% Define the parameter space
A = linspace(p1(1), p1(2),n);
B = linspace(p2(1), p2(2),n);

IC = zeros(6,1);
time_vector = 0:0.5:2000;
opts = odeset('RelTol',1e-6,'AbsTol',1e-8);
out.amplitude=zeros(length(A), length(B));
out.put = zeros(length(A), length(B),2);

X1=0:0.05:0.5;
X2=0:0.05:0.5;
[Gl, Gi] = meshgrid(X1,X2);
gridpts=[Gl(:), Gi(:)];

% Loop over the parameter space
for i =1:length(A)
    for j = 1:length(B)
        display([i,j])
        par.Kp=A(i);
        par.alpha=B(j);
        for k = 1:length(gridpts)
            IC(1:2) = [gridpts(k,:)];
            sol=ode45(@MePD_sys,time_vector,IC,opts, par);
            newIC = sol.y(:,end);
            newIC(4:6,1)=0;
            [T, Y]=ode45(@MePD_sys,time_vector,newIC,opts, par);
            out.amplitude(i,j) = max(Y(:,1))-min(Y(:,1));
            if out.amplitude(i,j)>0.01
                % Normalise
                out.put(i,j,1) = Y(end,4)/time_vector(end);
                out.put(i,j,2) = Y(end,6)/time_vector(end);
                break
            end
        end
    end
end
%%
save("Kp_alpha1.mat", "A", "B", "out")