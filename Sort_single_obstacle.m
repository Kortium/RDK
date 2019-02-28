function obstacle = Sort_single_obstacle(RDK, obstacle)
    x = sum(obstacle.points(:,1));
    y = sum(obstacle.points(:,2));
    l = length(obstacle.points);
%     center=[x/l,y/l];
    center = [RDK.x, RDK.y];
    angle=zeros(1,l);
    for i=1:l
        point = obstacle.points(i,:);
        angle(i) = atan2(center(2)-point(2),center(1)-point(1));
    end
    
    for j=1:l-1
        for i=1:l-j
            if angle(i)>angle(i+1)
                san = angle(i);
                angle(i) = angle(i+1);
                angle(i+1) = san;
                sp = obstacle.points(i,:);
                obstacle.points(i,:) = obstacle.points(i+1,:);
                obstacle.points(i+1,:) = sp;
            end
        end
    end
end