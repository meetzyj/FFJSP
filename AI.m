 % 这里假设两个模糊数都被表示为一维数组的形式
function value = AI(triplet,doublet)
    areaC = (triplet(3) - triplet(1)) / 2;
    if triplet(3) <= doublet(1)
        value = 1;
    elseif (triplet(3)<doublet(2)) && (triplet(2)<=doublet(1))
        value = 1;
    elseif triplet(1)>doublet(2)
        value = 0;
    else 
        if (triplet(3)>doublet(2)) && (triplet(2)<doublet(1)) % 只有一个交点
            common_area = (triplet(3)-doublet(2)) / (doublet(1)-doublet(2)+triplet(3)-triplet(2)) * (triplet(3)-doublet(2)) / 2;
            value = 1 - (common_area/areaC);
        elseif (triplet(2)>doublet(1)) && (triplet(1)<doublet(2))
            area = (triplet(1)-doublet(2)) / (doublet(1)-doublet(2)+triplet(1)-triplet(2)) * (doublet(2)-triplet(1)) / 2;
            value = area / areaC;
        else
            y1 = (triplet(1)-doublet(2)) / (doublet(1)-doublet(2)+triplet(1)-triplet(2));
            x1 = (doublet(1)-doublet(2))*y1 + doublet(2); 
            y2 = 1;
            x2 = triplet(2);
            y3 = (triplet(3)-doublet(2)) / (doublet(1)-doublet(2)+triplet(3)-triplet(2));
            x3 = (doublet(1)-doublet(2))*y3 + doublet(2); 
            area = abs(x1*y2+x2*y3+x3*y1-x1*y3-x2*y1-x3*y2)/2;
            value = 1 - (area/areaC);
        end 
    end 
end 
