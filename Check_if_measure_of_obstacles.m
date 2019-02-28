function check=Check_if_measure_of_obstacles(dot,obstacle)
    check = true;
    for i=1:length(obstacle.points)
        if (size(obstacle.points,1)==1)
            obp = obstacle.points;
        else
            obp = obstacle.points(i,:);
        end
        d = distance_between_points(dot,obp);
        check = d<0.6;
        if check 
            break
        end
    end
end