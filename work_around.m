function new_point = work_around(RDK, move_collisions, obstacles)
    add_l = 0.4;
    l = length(move_collisions);
    if l>1
        for j=1:l-1
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
    collision = move_collisions(1,:);
    obstacle = obstacles(1).points;
     
    n_points = length(obstacle.points);
    sd=zeros(1,n_points);
    v_n = 1;
    v_d = 0;
    for i=2:n_points-1
        point = obstacle.points(i,:);
        prev_point = obstacle.points(i-1,:);
        next_point = obstacle.points(i+1,:);
        sd(i) = distance_between_points(point,prev_point)+distance_between_points(point,next_point);
        if v_d<sd(i)
            v_d = sd(i);
            v_n = i;
        end
    end

    vertice = obstacle.points(v_n,:);
    
    direction = vertice - collision;

    if collision(1)==vertice(1)
        new_direction = [add_l+direction(1),direction(2)];
    elseif collision(2)==vertice(2)
        new_direction = [direction(1),add_l+direction(2)];
    else
        xk = direction(1)/sum(direction);
        yk = direction(2)/sum(direction);
        new_direction = [sign(direction(1))*add_l*xk+direction(1),sign(direction(2))*add_l*yk+direction(2)];
    end
    new_point = new_direction+collision;
end