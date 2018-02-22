function collision_points = Collision_detection(RDK,measured_obstacles)
    section = [RDK.x, RDK.y; RDK.targetX, RDK.targetY];
    angle = RDK.theta;
    collision_points = [];
    DCM = [cos(angle) sin(angle); -sin(angle) cos(angle)];
    k=1;
    if length(measured_obstacles)>1
        for i=1:length(measured_obstacles)
            obstacle = measured_obstacles(i);
            intersections = Get_section_intersection_with_obstacle(section, obstacle);
            if ~isempty(intersections)
                for j=1:size(intersections,1)
                    try
                        collision_points(k,:)=intersections(j,:);
                        k=k+1;
                    catch
                        k=k+1;
                    end
                end
            end
        end
    end
    if isempty(collision_points)
        collision_points=false;
    end
end