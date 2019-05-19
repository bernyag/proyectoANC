%Problemas de valor inicial, ecuaciones de primer orden

%Ejercicio 1
%y(0) = 1
% a) y' = t
% b) y' = t^2*y
% c) y' = 2*(t+1)*t

f = @(t,y) t^2*y;
[t,y] = ivps(f,0,2,1,0.1,4)
plot (t,y)

%Ejercicio 2
% y1' = -0.5*y1                 y1(0) = 4
% y2' = 4 - 0.3*y2 - 0.1*y1     y2(0) = 6

% f = @(t,y1y2) [-0.5*y1y2(1); 4 - 0.3*y1y2(2) - 0.1*y1y2(1)];
% vi=[4;6];
% [t,y1y2] = ivps(f,0,2,vi,0.5,1)
% plot(t,y1y2)
% legend ('y1','y2')




