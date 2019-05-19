function [t,y] = ivps2(f, t0, tf, y0, h, solver)
    [m,n] = size(y0);
    switch solver
        case 1
            fhandle = @euler;
        case 2
            fhandle = @trap;
        case 3
            fhandle = @midpoint;
        case 4
            fhandle = @ralston;
        otherwise
            fhandle = @rk4;
    end

    t = t0:h:tf;
    %y = zeros(size(t)); este era para solo vector ahora queremos matriz
    y = zeros(length(y0),  length(t)*n);
    y(:, 1:n)=y0;
    
    for i = 1:length(t)-1
        yn = y0 + h*fhandle(f,t(i), y0, h);
        for j = (i*n)+1:(i*n)+1+n-1
            y(:,j) = yn(:,j-(i*n));
        end
        y0=yn;
    end
    
    
    function phi = euler(f, t, y, ~)
        phi = f(t,y);
    end

    function phi = trap(f, t, y, h)
        s1 = f(t,y);
        yp = y + h * s1;
        s2 = f( t+h, yp );
        phi = (s1+s2)/2;
    end

    function phi = midpoint(f, t, y, h)
        s1 = f(t, y);
        ym = y + (h/2) * s1;
        phi = f( (t + h/2) , ym);
    end

    function phi = rk4(f, t, y, h)

        s1 = f(t,y);     
        s2 = f(t+h/2, y + (h/2) * s1);       
        s3 = f(t+h/2, y + (h/2) * s2);
        s4 = f(t+h, y + h * s3);
        
        phi = (s1 + 2*s2 + 2*s3 +s4)/6;
    end

    function phi = ralston(f, t, y, h)

        s1 = f(t,y);     
        s2 = f(t+(3/4)*h, y + (3/4) * s1 * h);       
        
        phi = (1/3)*s1 + (2/3)*s2;
    end

    
end

