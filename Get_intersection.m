function intersection = Get_intersection(ray_segment,obstacle_segment)
    s1(1) = ray_segment(2,1)-ray_segment(1,1);
    s1(2) = ray_segment(2,2)-ray_segment(1,2);
    
    s2(1) = obstacle_segment(2,1)-obstacle_segment(1,1);
    s2(2) = obstacle_segment(2,2)-obstacle_segment(1,2);
    
    s = (-s1(2)*(ray_segment(1,1)-obstacle_segment(1,1)) + s1(1)*(ray_segment(1,2)-obstacle_segment(1,2)))/(-s2(1)*s1(2) + s1(1)*s2(2));
    t = (s2(1)*(ray_segment(1,2)-obstacle_segment(1,2)) - s2(2)*(ray_segment(1,1)-obstacle_segment(1,1)))/(-s2(1)*s1(2) + s1(1)*s2(2));
    
    if(s>=0 && s<= 1 && t>=0 && t<=1)
        intersection(1) = ray_segment(1,1)+(t*s1(1));
        intersection(2) = ray_segment(1,2)+(t*s1(2));
    else
        intersection = [];
    end
end