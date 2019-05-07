% Un satélite orbitando la Tierra
% La Tierra en el origen (inicialmente)
% El satélite tiene una masa de 20 toneladas 
% y se encuentra a 108 km de altura (eje x)
% Los vectores tienen los datos [Tierra, satélite]
  
% y  = [r;v] 
% y' = [v;a]
% dy/dt = f(t,y)

global G m;
G = 6.67408E-11;              % m3 kg-1 s-2
mT = 5.9736E+24;              % masa de la Tiera
ms = 20000;                   % masa del satélite
m = [mT, ms]; 

rT = 6371e3;                        % radio de la Tierra m
hs = 35786000;                      % altura satélite geoestacionario m        
r0 = [ [0;0;0], [rT+hs;0;0] ];      
vs = sqrt(G * m(1)/r0(1,2));        
v0 = [ [0;0;0], [0;vs;0] ];         

ws = vs/(rT+hs);
T = (2*pi)/ws;
h = 60;                 
nv = 4;                 
Nk = nv*ceil(T/h);       
pos = zeros(6,Nk+1);    
pos(:,1) = [r0(:,1);r0(:,2)]; 

%Esto es un rk4
y = [r0;v0];
for t=2:Nk+1
  s1 = f(t,y);
  s2 = f(t+h/2,y+(h/2)*s1);
  s3 = f(t+h/2,y+(h/2)*s2);
  s4 = f(t+h, y+h*s3);
  slope = (s1+2*s2+2*s3+s4)/6;
  %slope = s1; %con esto es euler
  y = y + slope*h;

  r = y(1:3,:); 
  pos(:,t) = [r(:,1);r(:,2)];         
end

plot3(pos(1,:),pos(2,:),pos(3,:),'ob');
hold on;
plot3(pos(4,:),pos(5,:),pos(6,:),'.k');
grid minor;
 
function ydot = f(~,y)
  global G m;                 
  r = y(1:3,:);
  v = y(4:6,:);
  dr = r(:,2) - r(:,1);         
  u = dr / norm(dr);            
  dr2 = norm(dr)^2;         	 
  F = (G*m(1)*m(2)/dr2) * u;    
  a = [F/m(1), - F/m(2)];       
  ydot = [v;a];
end
