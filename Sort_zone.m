function zone = Sort_zone(zone)
    x = sum(zone(:,1));
    y = sum(zone(:,2));
    l = length(zone);
    center=[x/l,y/l];
    angle=zeros(1,l);
    for i=1:l
        point = zone(i,:);
        angle(i) = atan2(center(2)-point(2),center(1)-point(1));
    end
    
    for j=1:l-1
        for i=1:l-j
            if angle(i)>angle(i+1)
                san = angle(i);
                angle(i) = angle(i+1);
                angle(i+1) = san;
                sp = zone(i,:);
                zone(i,:) = zone(i+1,:);
                zone(i+1,:) = sp;
            end
        end
    end
end