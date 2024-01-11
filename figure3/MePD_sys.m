function xdot=MePD_sys(~,x,par)

% initialise the system

xdot=zeros(6,1);


% PARAMETERS 


d = par.d; % Time Scaling Constant 
cll = par.cll; % Gl self-excitation coupling constant 
cil = par.cil; % Gi to Gl inhibition coupling constant 
cli = par.cli; % Gl to Gi excitation coupling constant 
cii = par.cii; % Gi self-inhibition coupling constant
cel = par.cel; % Gp to Gl inhibition coupling constant 
cei = par.cei; % Gp to Gi inhibition coupling constant
cle = par.cle; % Gl to Gp excitation coupling constant 
cie = par.cie; % Gp to Gi inhibition coupling constant 
cee = par.cee; % Gp self-inhibition coupling constant 
al = par.al; % maximum slope for the Gl response function
ai = par.ai; %  maximum slope  for the Gi response function 
ae = par.ae; %  maximum slope  for the Gp response function 
beta1 = par.beta1;% effective strength of GABA receptor antagonist 
beta2 = par.beta2;% effective strength of GABA receptor antagonist
thetal = par.thetal; % half-maximum firing threshold for Gl response function 
thetai = par.thetai; %  half-maximum firing threshold for Gi response function 
thetae = par.thetae;  % half-maximum firing threshold for Gp response function 
Kp = par.Kp;  % Kisspeptin input 
alpha = par.alpha; % Kisspeptin non-dimensional ration constant 

% define the inputs into the sigmoid function 

Fl = (1-beta2)*cll*x(1)-(1-beta1)*cil*x(2)-cel*x(3)+alpha*Kp;
Fi = (1-beta2)*cli*x(1)-cii*x(2)-cei*x(3)+(1-alpha)*Kp;
Fe = (1-beta2)*cle*x(1)-(1-beta1)*cie*x(2)-cee*x(3);

% define the sigmoid function 

function out=phi(a,F,theta)
    out = 1./(1+exp(-a.*(F-theta)))-1./(1+exp(a.*theta));
end

% define the system of ODEs

xdot(1)=d*(-x(1)+(1-x(1)).*phi(al,Fl,thetal)); %glut
xdot(2)=d*(-x(2)+(1-x(2)).*phi(ai,Fi,thetai)); %gaba inter
xdot(3)=d*(-x(3)+(1-x(3)).*phi(ae,Fe,thetae)); %gaba eff

% Functions for calculating the progression of system's output

xdot(4)=x(1);
xdot(5)=x(2);
xdot(6)=x(3);

end