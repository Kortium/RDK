function [avoidingT, avoidingH, point] = Collision_avoid(RDK, measured_distance)
    persistent avoiding_angle_old
    if isempty(avoiding_angle_old)
        avoiding_angle_old=0;
    end
    shir = 0.9;
    if RDK.Avoiding_obstacle
        [heading_block, ~] = check_range(0, measured_distance, shir, 1.5);
    else
        [heading_block, ~]= check_range(0, measured_distance, shir, 0.5);
    end 
    if (RDK.targetX - RDK.x)<0
        target_bind_heading = pi_to_pi(RDK.get_target_bind_direction(true));
    else
        target_bind_heading = pi_to_pi(RDK.get_target_bind_direction(false));
    end
    [target_block, outd] = check_range(target_bind_heading, measured_distance, shir, RDK.get_target_distance(),RDK);

    if target_block || heading_block
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
        
        d = RDK.get_target_distance();
        d_angle = 0.2;
        plus_found = false;
        minus_found = false;
        [old_block, ~] = check_range(target_heading+avoiding_angle_old, measured_distance, shir+0.1,d, RDK);
        if ~old_block && avoiding_angle_old<0.2 
            avoiding_angle = avoiding_angle_old;
        else
            while (~plus_found || ~minus_found)
                if ~plus_found
                    avoiding_angle_plus = pi_to_pi(avoiding_angle_plus + d_angle);
                    [avoiding_block, ~] = check_range(pi_to_pi(avoiding_angle_plus+target_bind_heading), measured_distance, shir,d, RDK);
                    if ~avoiding_block
                        plus_found = true;
                    end
                end
                if ~minus_found
                    avoiding_angle_minus = pi_to_pi(avoiding_angle_minus - d_angle);
                    [avoiding_block, ~] = check_range(pi_to_pi(avoiding_angle_minus+target_bind_heading), measured_distance, shir,d, RDK);
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
        end

        avoiding_angle_old = avoiding_angle;
        if (RDK.targetX - RDK.x)>0
            X = RDK.x+cos(target_heading+avoiding_angle)*d;
            Y = RDK.y+sin(target_heading+avoiding_angle)*d;
        else
            X = RDK.x+cos(target_heading+avoiding_angle)*d;
            Y = RDK.y+sin(target_heading+avoiding_angle)*d;
        end
        point = [X,Y];
%     elseif heading_block
%         avoidingH = true;
%         avoidingT = false;
%         X = RDK.x-cos(RDK.theta)*4;
%         Y = RDK.y-sin(RDK.theta)*4;
%         point = [X,Y];
    else
        avoidingT = false;
        avoidingH = false;
        point = [0,0];
    end
end

function D = cutting_edge(d_range, d, measure_angle, angle)
    D=d;
    if abs(D*sin(measure_angle+angle)) > d_range
        A1 = abs(D*sin(measure_angle+angle))-d_range;
        A2 = (A1/abs(D*sin(measure_angle+angle)))*abs(D*cos(measure_angle+angle));
        D = D - sqrt(A1^2 +A2^2);
        if abs(D)>d
            D=d;
        end
    end
end

function [is_blocked, block_dist] = check_range(angle, measures, dist, d, RDK)
    block_dist = 50;
    is_blocked = false;
    an = ones(length(measures),1);
    di = ones(length(measures),1);
    for i=1:length(measures)
        measure_angle = pi_to_pi(-i*2*pi/180);
        an(i) = measure_angle;
        di(i) = 0 ;
        if pi_to_pi(measure_angle+angle)<pi/2 || pi_to_pi(measure_angle+angle)>3*pi/2
            limit = cutting_edge(dist, d, measure_angle, angle);
            di(i) = limit;
            if measures(i)>0.1 && measures(i)<limit
                is_blocked = true;
                if measures(i)<block_dist
                    block_dist = measures(i);
                    
                end
            end
        end
    end
%     if dist == 1.0
%         plotedge(an+pi/2, di, RDK)
%     end
end

function plotedge(angle,d, RDK)
persistent line

x = ones(length(angle),1)';
y = ones(length(angle),1)';
for i=1:length(angle)
   x(i) = sin(angle(i))*d(i)+RDK.x;
   y(i) = cos(angle(i))*d(i)+RDK.y;
end
if isempty(line) || ~ishghandle(line)
    line=plot(x,y);
else
    set(line,'xdata',x,'ydata', y);
end
axis equal
end

% function [is_blocked, block_dist] = check_range(angle, measures, disp, d)
%     if angle<disp
%         id = pi_to_pi(angle-disp)<=((1:length(measures))*(2*pi/length(measures)))|((1:length(measures))*(2*pi/length(measures)))<=pi_to_pi(angle+disp);
%     elseif 2*pi-angle<disp
%         id = pi_to_pi(angle-disp)<=((1:length(measures))*(2*pi/length(measures)))|((1:length(measures))*(2*pi/length(measures)))<=pi_to_pi(angle+disp);
%     else
%         id = angle-disp<=((1:length(measures))*(2*pi/length(measures)))&((1:length(measures))*(2*pi/length(measures)))<=angle+disp;
%     end
%     is_blocked = any(measures(id)<d);
%     block_dist = min(measures(id));
% end

