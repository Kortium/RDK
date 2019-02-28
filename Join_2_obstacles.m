function obstacle1 = Join_2_obstacles(obstacle1, obstacle2)
    obstacle1.points = [obstacle1.points; obstacle2.points];
end