classdef RDK_class
    properties
        x = -10.1422725340136;
        y = 5;
        targetX = 0;
        targetY = 0;
        workAroundX = 0;
        workAroundY = 0;
        Avoiding_obstacle = false;
        Avoiding_heading = false;
        theta = 0;
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
        function angle = get_target_bind_direction(obj,inverse)
            if inverse
                target_angle = pi_to_pi(atan2(obj.targetY-obj.y,obj.targetX-obj.x));
                angle = pi_to_pi(target_angle-obj.theta);
            else
                target_angle = pi_to_pi(atan2(obj.targetY-obj.y,obj.targetX-obj.x));
                angle = pi_to_pi(target_angle-obj.theta);
            end
        end
        function angle = get_target_direction(obj)
            target_angle = pi_to_pi(atan2(obj.targetY-obj.y,obj.targetX-obj.x));
            angle = pi_to_pi(target_angle);
        end
        function distance = get_target_distance(obj)
            distance = sqrt((obj.targetY-obj.y)^2+(obj.targetX-obj.x)^2);
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