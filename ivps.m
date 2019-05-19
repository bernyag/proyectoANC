
function [ t,y ] = ivps( f, t0, tf, y0, h, solver)
%Solucionador de problemas de valor inicial
    switch solver
        case 1
            fhandle = @euler;
        case 2
            fhandle = @trap;
        case 3
            fhandle= @midpoint;
        case 4
            fhandle = @rk4;
        otherwise
            fhandle = @ralston;
    end

%  
%     t = t0:h:tf;
%     y = zeros(length(y0),length(t));
%     y(:,1:3) = y0;

    [m,n] = size(y0); 
    t = t0:h:n*tf;
    
    y = zeros(m,length(t));
    y(:,1:n) = y0;
    for i=1:n:length(t)-1
        y(:,i+n:i+((n*2)-1)) = y(:,i:i+n-1) + h*fhandle(f,t(i),y(:,i:i+n-1),h);
    end 
    
    function phi = euler (f,t,y,~)
        phi = f(t,y);
    end

    function phi = trap (f,t,y,h)
        s1 = f(t,y);
        yp = y + h*s1;
        s2 = f(t+h,yp);
        phi = (s1+s2)/2;
    end

    function phi = midpoint(f,t,y,h)
        s1 = f(t,y);
        yt = y + (h/2)*s1; 
        phi= f(t + h/2, yt); 
    end

    function phi = rk4(f,t,y,h)
        s1 = f(t,y);
        s2 = f(t+h/2, y + (h/2)*s1);
        s3 = f(t+h/2, y + (h/2)*s2);
        s4 = f(t+h, y + h*s3);
        phi = (s1 + 2*s2 + 2*s3 + s4)/6;
    end

    function phi = ralston(f,t,y,h)
        k1 = f(t,y);
        k2 = f(t+(3/4)*h, y + (3/4)*k1*h);
        phi = (1/3)*k1 + (2/3)*k2;
    end
end

