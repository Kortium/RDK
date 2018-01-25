function intersections = Get_section_intersection_with_obstacle(section,obstacle)
    intersections = false;
    vertices = obstacle.points;
    if length(obstacle.points)>1
        vertices(end+1,:) = obstacle.points(1,:);
        k=1;
        for i = 2:length(vertices)
            j = i-1;
            intersection = Get_intersection(section, vertices(j:i,1:2));
            if intersection~=false
                if Length_between(ray.start,ray.end)>Length_between(ray.start,intersection)
                    intersections(k,:)=intersection;
                    k=k+1;
                end
            end
        end
    end
end