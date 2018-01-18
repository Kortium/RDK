function measure_model=measure_draw(laser_lines, ray_length)
    measure_model=zeros(2,length(laser_lines));
    j=1;
%     for i=1:length(laser_lines)
%         laser_model(i,1) = laser_lines(2,1,i);
%         laser_model(i,2) = laser_lines(2,2,i);
%     end
    for i=1:length(laser_lines)
        d = sqrt((laser_lines(1,1,i)-laser_lines(2,1,i))^2 +(laser_lines(1,2,i)-laser_lines(2,2,i))^2);
        if d<ray_length-0.001
            angle = pi_to_pi(i*(360/length(laser_lines)/180)*pi+pi/2);

            x = cos(angle)*d;
            y = sin(angle)*d;

            measure_model(j,1) = x;
            measure_model(j,2) = y;
            j=j+1;
        end
    end
end