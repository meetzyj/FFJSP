function value = maxop(s,t)
    fs = (s(1)+2*s(2)+s(3));
    ft = (t(1)+2*t(2)+t(3));
    if fs>ft
        value = s;
    elseif fs<ft 
        value = t;
    else 
        if s(2)>t(2)   
            value = s; 
        elseif s(2)<t(2)
            value = t;  
        else 
            if (s(3)-s(1))>(t(3)-t(1)) 
                value = s;  
            else 
                value = t;
            end 
        end 
    end 
end 
