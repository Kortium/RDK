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
%             point = obstacle.points(i,:);
%             if i==1
%                 prev_point = obstacle.points(end,:);
%             else
%                 prev_point = obstacle.points(i-1,:);
%             end
%             if i==n_points
%                 next_point = obstacle.points(1,:);
%             else
%                 next_point = obstacle.points(i+1,:);
%             end
%             sd(i) = distance_between_points(point,prev_point)+distance_between_points(point,next_point);
            if v_a<sa(i)
                v_a = sa(i);
                v_n = i;
            end
        end
    end

    vertice = obstacle.points(v_n,:);
    
%     direction = vertice - collision;
%     direction2 = ([RDK.x, RDK.y] - collision)./distance_between_points([RDK.x, RDK.y],collision);
% 
%     if collision(1)==vertice(1)
%         new_direction = [add_l+direction(1),direction(2)];
%     elseif collision(2)==vertice(2)
%         new_direction = [direction(1),add_l+direction(2)];
%     else
%         xk = direction(1)/sum(direction);
%         yk = direction(2)/sum(direction);
%         
%         new_direction = [sign(direction(1))*add_l*xk+direction(1)+add_l*direction2(1),sign(direction(2))*add_l*yk+direction(2)+add_l*direction2(2)];
%     end
    if (distance_between_points(collision,vertice)<0.2)
        new_point =  [RDK.targetX, RDK.targetY];
    else
        new_point = [vertice(1)+0.6*sign(RDK.x-collision(1)),vertice(2)+0.6*sign(RDK.y-collision(2))];
    end
end