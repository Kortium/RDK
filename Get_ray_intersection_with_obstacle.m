function fin_intersection = Get_ray_intersection_with_obstacle(ray,vertices)
    fin_intersection = false;
    for i = 2:length(vertices)
        j = i-1;
        intersection = Get_intersection([ray.start; ray.end], vertices(j:i,1:2));
        if intersection~=false
            if Length_between(ray.start,ray.end)>Length_between(ray.start,intersection)
                ray.end = intersection;
                fin_intersection = intersection;
            end
        end
    end
end