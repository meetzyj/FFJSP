function value = larger(s,t)
    fs = (s(1)+2*s(2)+s(3));
    ft = (t(1)+2*t(2)+t(3));
    if fs>ft
        value = true;
    elseif fs<ft 
        value = false;
    else 
        if s(2)>t(2)   
            value = true; 
        elseif s(2)<t(2)
            value = false;  
        else 
            if (s(3)-s(1))>(t(3)-t(1)) 
                value = true;  
            else 
                value = false;
            end 
        end 
    end 
end 