classdef RDK_class
    properties
        x = -7;
        y = 0;
        targetX = 0;
        targetY = 0;
        workAroundX = 0;
        workAroundY = 0;
        Avoiding_obstacle = false;
        theta = -pi/4;
    end
    methods
        function obj = move (obj, V, w,dt)
            obj.theta = pi_to_pi(obj.theta + w*dt);
            obj.x = obj.x + V*cos(obj.theta)*dt;
            obj.y = obj.y + V*sin(obj.theta)*dt;
        end
        function angle = get_bind_direction(obj,point)
            point_angle = atan2(obj.y-point(2),obj.x-point(1));
            target_angle = atan2(obj.y-obj.targetY,obj.x-obj.targetX);
            angle = minus_pi_to_pi(target_angle - point_angle);
        end
    end
end
function angle=minus_pi_to_pi(angle)
    if angle>pi 
        angle = angle-2*pi;
    elseif angle<-pi 
        angle = angle+2*pi;
    end
end