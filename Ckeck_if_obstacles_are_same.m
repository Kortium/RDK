function same = Ckeck_if_obstacles_are_same(obstacle1, obstacle2)
    same=false;
    for i=1:length(obstacle1.points)
        if (size(obstacle1.points,1)>1)
            p1= obstacle1.points(i,:);
        else
            p1= obstacle1.points;
        end
        for j=1:length(obstacle2.points)
            if (size(obstacle2.points,1)>1)
                p2 = obstacle2.points(j,:);
            else
                p2= obstacle2.points;
            end
            d = distance_between_points(p1,p2);
            same = d<0.6;
            if same
                break
            end
        end
    end
end