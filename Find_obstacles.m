function obstacles = Find_obstacles(laser_measures)
    obstacles=struct('points',[]);
    k=1;
    for i=1:length(laser_measures)
        if (laser_measures(i,1)~=0 && laser_measures(i,2)~=0)
            for j=1:length(obstacles)
                check = Check_if_measure_of_obstacles(laser_measures(i,:),obstacles(j));
                if (check)
                    obstacles(j).points(end+1,:)=laser_measures(i,:);
                    break
                end
            end
            if ~check
                k=k+1;
                obstacles(k).points(1,:)=laser_measures(i,:);
            end
        end
    end
end