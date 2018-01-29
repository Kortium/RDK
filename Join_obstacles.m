function obstacles = Join_obstacles(obstacles)
    if length(obstacles)>1
        for i=1:length(obstacles)-1
            for j=i+1:length(obstacles)
                check = Ckeck_if_obstacles_are_same(obstacles(i),obstacles(j));
                if check
                    obstacles(i)=Join_2_obstacles(obstacles(i),obstacles(j));
                end
            end
        end
    end
end