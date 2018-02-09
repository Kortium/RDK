function collision_points = Collision_detection(RDK,measured_obstacles)
    section = [RDK.x, RDK.y; RDK.targetX, RDK.targetX];
    angle = RDK.theta;
    collision_points = false;
    DCM = [cos(angle) sin(angle); -sin(angle) cos(angle)];
    k=1;
    if length(measured_obstacles)>1
        for i=1:length(measured_obstacles)
            obstacle = measured_obstacles(i);
            for j=1:size(obstacle.points,1)
                if (length(obstacle.points)==1)
                    obstacle.points(j,:) = [obstacle.points(1)+RDK.x, obstacle.points(2)+RDK.y];
                else
                    obstacle.points(j,:) = [obstacle.points(j,1)+RDK.x, obstacle.points(j,2)+RDK.y];
                end
            end
            obstacle.points = obstacle.points*DCM;
            intersections = Get_section_intersection_with_obstacle(section, obstacle);
            if intersections
                for j=1:length(intersections)
                    collision_points(k,:)=intersections(j,:)
                    k=k+1;
                end
            end
        end
    end
end