function obstacles = Sort_obstacles(obstacles)
    for i=1:length(obstacles)
        obstacles(i)=Sort_single_obstacle(obstacles(i));
    end
end