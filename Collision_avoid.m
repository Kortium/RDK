function [avoidingT, avoidingH, point] = Collision_avoid(RDK, measured_distance)
    if RDK.Avoiding_obstacle
        [heading_block, ~] = check_range(0, measured_distance, 0.3, 1.5);
    else
        [heading_block, ~]= check_range(0, measured_distance, 0.3, 0.5);
    end 
    if (RDK.targetX - RDK.x)<0
        target_bind_heading = pi_to_pi(RDK.get_target_bind_direction(true));
    else
        target_bind_heading = pi_to_pi(RDK.get_target_bind_direction(false));
    end
    [target_block, ~] = check_range(target_bind_heading, measured_distance, 0.3, RDK.get_target_distance());

    if target_block
        if (RDK.targetX - RDK.x)<0
            target_heading = pi_to_pi(RDK.get_target_direction());
        else
            target_heading = pi_to_pi(RDK.get_target_direction());
        end
        avoidingT = true;
        avoidingH = false;
        avoiding_angle = 0;
        avoiding_angle_plus = avoiding_angle;
        avoiding_angle_minus = avoiding_angle;
        cnt = 0; 
        d = 2;
        d_angle = 0.6;
        plus_found = false;
        minus_found = false;
        while (~plus_found || ~minus_found)
            if ~plus_found
                avoiding_angle_plus = pi_to_pi(avoiding_angle_plus + d_angle);
                [avoiding_block, ~] = check_range(pi_to_pi(avoiding_angle_plus+target_bind_heading), measured_distance, 0.3,d);
                if ~avoiding_block
                    plus_found = true;
                end
            end
            if ~minus_found
                avoiding_angle_minus = pi_to_pi(avoiding_angle_minus - d_angle);
                [avoiding_block, ~] = check_range(pi_to_pi(avoiding_angle_minus+target_bind_heading), measured_distance, 0.3,d);
                if ~avoiding_block
                    minus_found = true;
                end
            end
            if cnt > 6000
                cnt = 0;
                d = d-0.5;
            end
            cnt = cnt+1;
        end
        if (abs(RDK.theta-target_heading-avoiding_angle_plus)<abs(RDK.theta-target_heading-avoiding_angle_minus))
            avoiding_angle=avoiding_angle_plus;
        else
            avoiding_angle=avoiding_angle_minus;
        end
        
        if (RDK.targetX - RDK.x)>0
            X = RDK.x+cos(target_heading+avoiding_angle)*d;
            Y = RDK.y+sin(target_heading+avoiding_angle)*d;
        else
            X = RDK.x+cos(target_heading+avoiding_angle)*d;
            Y = RDK.y+sin(target_heading+avoiding_angle)*d;
        end
        point = [X,Y];
    elseif heading_block
        avoidingH = true;
        avoidingT = false;
        X = RDK.x-cos(RDK.theta)*2;
        Y = RDK.y-sin(RDK.theta)*2;
        point = [X,Y];
    else
        avoidingT = false;
        avoidingH = false;
        point = [0,0];
    end
end


function [is_blocked, block_dist] = check_range(angle, measures, disp, d)
    if angle<disp
        id = pi_to_pi(angle-disp)<=((1:length(measures))*(2*pi/length(measures)))|((1:length(measures))*(2*pi/length(measures)))<=pi_to_pi(angle+disp);
    elseif 2*pi-angle<disp
        id = pi_to_pi(angle-disp)<=((1:length(measures))*(2*pi/length(measures)))|((1:length(measures))*(2*pi/length(measures)))<=pi_to_pi(angle+disp);
    else
        id = angle-disp<=((1:length(measures))*(2*pi/length(measures)))&((1:length(measures))*(2*pi/length(measures)))<=angle+disp;
    end
    is_blocked = any(measures(id)<d);
    block_dist = min(measures(id));
end

