function laser_lines = Measure_laser(RDK, Obstacles, Rays, Ray_length)
    if (nargin<4) 
        Ray_length = 5;
    end
    vertices = zeros(5,2,length(Obstacles));
    center = [RDK.x RDK.y];
    for i = 1:length(Obstacles)
        vertices(:,:,i) = Square_graph_model (Obstacles(i));
    end
    laser_lines = zeros(2,2,Rays);
    for i=1:Rays
        obstacle_stops_the_ray = false;
        ray.start = center;
        ray.angle = pi_to_pi(((i*(360/Rays)/180)*pi)+RDK.theta);
        
        x = cos(ray.angle)*Ray_length;
        
        ray.end = [x+ray.start(1), tan(ray.angle)*x+ray.start(2)];
        for j=1:length(Obstacles)
            intersection = Get_ray_intersection_with_obstacle(ray,vertices(:,:,j));
            if intersection
                laser_lines(2,:,i) = intersection;
                obstacle_stops_the_ray = true;
            end
        end
        laser_lines(1,:,i) = ray.start;
        if ~obstacle_stops_the_ray
            laser_lines(2,:,i) = ray.end;
        end
    end
end