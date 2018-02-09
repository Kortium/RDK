function converted_obstacles = Convert_obstacle(RDK, obstacles)
    angle = RDK.theta;
    DCM = [cos(angle) sin(angle); -sin(angle) cos(angle)];
    converted_obstacles = obstacles;
    if length(obstacles)>1
        for i=1:length(obstacles)
            obstacle = obstacles(i);
            obstacle.points = obstacle.points*DCM;
            for j=1:size(obstacle.points,1)
                if (length(obstacle.points)==1)
                    obstacle.points(j,:) = [obstacle.points(1)+RDK.x, obstacle.points(2)+RDK.y];
                else
                    obstacle.points(j,:) = [obstacle.points(j,1)+RDK.x, obstacle.points(j,2)+RDK.y];
                end
            end
            converted_obstacles(i) = obstacle;
        end
    end
end