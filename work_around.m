function new_point = work_around(RDK, move_collisions, obstacles)
    add_l = 0.6;
    l = length(move_collisions);
    if l>1
        for j=1:l-1
            if j<length(move_collisions)-1
                lc1 = distance_between_points([RDK.x, RDK.y],move_collisions(j,:));
                lc2 = distance_between_points([RDK.x, RDK.y],move_collisions(j+1,:));
                if lc1>lc2
                    mcs = move_collisions(j);
                    move_collisions(j) = move_collisions(j+1);
                    move_collisions(j+1) = mcs;
                    pcs = obstacles(j).points;
                    obstacles(j).points = obstacles(j+1).points;
                    obstacles(j+1).points = pcs;
                end
            end
        end
    end
    collision = move_collisions(1,:);
    obstacle = obstacles(1).points;
     
    n_points = length(obstacle.points);
    sa=zeros(1,n_points);
    v_n = 1;
    v_a = 0;
    for i=1:n_points
        sa(i) = RDK.get_bind_direction(obstacle.points(i,:));
        if (RDK.get_bind_direction(obstacle.points(i,:))>0)
            if v_a<sa(i)
                v_a = sa(i);
                v_n = i;
            end
        end
    end

    vertice = obstacle.points(v_n,:);
    

    if (distance_between_points(collision,vertice)<0.2)
        new_point =  [RDK.targetX, RDK.targetY];
    else
        new_point = [vertice(1)+add_l*sign(vertice(1)-collision(1)),vertice(2)+add_l*sign(vertice(2)-collision(2))];
    end
end