function danger_zones = Find_danger_zones(RDK, obstacles)
    danger_zones=struct('points',[]);
    for i=1:length(obstacles)
        danger_zones(i) = Calculate_danger_zone(RDK, obstacles(i));
    end
end