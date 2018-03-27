function [laser_lines, measured_distance]  = Measure_laser(RDK, Obstacles, Rays, Ray_length)
    if (nargin<4) 
        Ray_length = 5;
    end
    vertices = zeros(5,2,length(Obstacles));
    center = [RDK.x RDK.y];
    for i = 1:length(Obstacles)
        if Obstacles(i).Type == 1
        vertices(:,:,i) = Square_graph_model (Obstacles(i));
        end
        if Obstacles(i).Type == 2
        vertices(:,:,i) = Big_triangle_graph_model (Obstacles(i));
        end
        if Obstacles(i).Type == 3
        vertices(:,:,i) = Rectangle_graph_model (Obstacles(i));
        end
    end
    laser_lines = zeros(2,2,Rays);
    measured_distance = zeros(1,Rays);
    for i=1:Rays
        ray.start = center;
        ray.angle = pi_to_pi(((i*(360/Rays)/180)*pi)+RDK.theta);
        
        x = cos(ray.angle)*Ray_length;
        
        ray.end = [x+ray.start(1), tan(ray.angle)*x+ray.start(2)];
        laser_lines(1,:,i) = ray.start;
        laser_lines(2,:,i) = ray.end;
        
        for j=1:length(Obstacles)
            intersection = Get_ray_intersection_with_obstacle(ray,vertices(:,:,j));
            if intersection
                if (length_ray(laser_lines(:,:,i),intersection)<length_ray(laser_lines(:,:,i)))
                    laser_lines(2,:,i) = intersection;
                end
            end
        end
        measured_distance(i) = length_ray(laser_lines(:,:,i));
    end
end

function length = length_ray(laser_line, point)
    start = laser_line(1,:);
    if nargin<2
        fin = laser_line(2,:);
    else
        fin = point;
    end
    length = sqrt((start(1)-fin(1))^2 +(start(2)-fin(2))^2);
end