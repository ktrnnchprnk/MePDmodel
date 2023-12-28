% Coupling of the KNDy network model with MePD outputs

function dx = KNDy(t,x,par)

%% KNDy model parameters

d1 = par.d1;  % Dyn degradation rate
d2 = par.d2;  % NKB degradation rate 
d3 = par.d3;  % Firing rate reset rate 
k1 = par.k1;  % Maximum Dyn secretion rate
k2 = par.k2;  % Maximum NKB secretion rate
k01 = par.k01;  % Basal Dyn secretion rate 
k02 = par.k02;  % Basal NKB secretion rate 
pr = par.pr;  % Effective strength of synaptic input
v0 = par.v0;  % Maximum rate of neuronal activity increase 
KD = par.KD;  % Dyn IC50
KN = par.KN;  % NKB EC50
Kr1 =par.Kr1;  % Firing rate for half-maximal Dyn secretion  
Kr2 =par.Kr2;  % Firing rate for half-maximal NKB secretion
theta = par.theta; % half-maximal firing rate 
k = par.k; 
I0= par.I0;

%% MePD model parameters 

d = par.d; % glutamate time scale constant
a_Gl = par.aGl; % max slope for the glutamate response function 
theta_Gl = par.thetaGl; % location of the max slope for the glutamate response function
a_inhib = par.ainhib; % max slope for the GABA response function 
theta_inhib = par.thetainhib; % location of the max slope for the GABA response function
cll = par.cll; % glutamate self-excitation  
cil = par.cil; % inhibition from GABA to glutamate
cli = par.cli; % excitation from glutamate to GABA
cii = par.cii; % self-inhibition of GABA
cel = par.cel; % inhibition from GABA IN to glutamate
cei = par.cei; % inhibition from GABA IN to GABA
cle = par.cle; % excitation from glutamate to GABA IN
cie = par.cie; % inhibition from GABA to GABA IN
cee = par.cee; % self-inhibition of GABA IN
Kp = par.Kp; % afferent input from kisspeptin
alpha = par.alpha;
jl = par.jl; % ratio parameter
je = par.je;
beta1 = par.beta1;
beta2 = par.beta2;
%% State variables
 Gl = x(1); % MePD glutamate population activity
 Gi = x(2); % MePD GABA population activity
 Ge = x(3); % MePD GABA IN population activity
 Dyn = x(4); % Dyn levels
 NKB = x(5); % NKB levels
 v = x(6); % firing rate of kisspeptin neurons in KNDy
 %% Model equations

dx = zeros(size(x));

% MePD input functions 
Gl_input = (1-beta2)*cll*Gl - (1-beta1)*cil*Gi-cel*Ge...
    + Kp*alpha;
Gi_input = (1-beta2)*cli*Gl - cii*Gi ...
    - cei*Ge + Kp*(1-alpha);
Gp_input = (1-beta2)*cle*Gl - (1-beta1)*cie*Gi - cee*Ge;

% equation for glutamate MePD neurons
dx(1) = d.*(-Gl+( 1-Gl ).*(1./(1+ ...
    exp(-a_Gl.*(Gl_input-theta_Gl)))-1./(1 ...
    +exp(a_Gl.*theta_Gl))));

% equation for GABA MePD interneurons
dx(2) = d.*(-Gi +(1-Gi).* ...
    (1./(1+exp(-a_inhib.*(Gi_input-theta_inhib))) - ...
    1./(1+exp(a_inhib.*theta_inhib))));

% equation for GABA MePD projection neurons
dx(3) = d.*(-Ge +(1-Ge)* ...
    (1./(1+exp(-a_inhib.*(Gp_input-theta_inhib))) - ...
    1./(1+exp(a_inhib.*theta_inhib))));

% Equation for Dyn 
dx(4) = k01 + k1.*v.^2./(v.^2+(Kr1).^2)-Dyn.*d1;

% Equation for NKB 
dx(5) = k02 + k2.*v.^2./(v.^2+(Kr2).^2)*KD.^2./(Dyn.^2+KD.^2)-d2.*NKB;

% Basal activity function
Im=jl.*Gl-je.*Ge;
I = I0 + Im + pr.*NKB.^2.*v./(NKB.^2+KN.^2);

% Equation for ARC kisspeptin firing rate
dx(6) = v0.*(1./(1+exp(k*(-I+theta))))-d3.*v;
end