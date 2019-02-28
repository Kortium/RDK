function obstacles = Sort_obstacles(RDK, obstacles)
    for i=1:length(obstacles)
        if size(obstacles(i).points,1)>1
            obstacles(i) = Sort_single_obstacle(RDK, obstacles(i));
        end
    end
end