function danger_zone = Calculate_danger_zone(RDK, obstacle)
    danger_zone.points = obstacle.points;
    x = RDK.x;
    y = RDK.y;
    add = 0.6;
    
    Xc1 = mean(obstacle.points(:,1));
    Yc1 = mean(obstacle.points(:,2));
    Xc = (Xc1-x)*2 +x;
    Yc = (Yc1-y)*2 +y;
    for i = 1:size(obstacle.points,1)
        d = distance_between_points([Xc,Yc],obstacle.points(i,:));
        xp = (obstacle.points(i,1)-Xc)/d;
        yp = (obstacle.points(i,2)-Yc)/d;
        danger_zone.points(i,:) = [obstacle.points(i,1)+xp*add,obstacle.points(i,2)+yp*add];
    end
end