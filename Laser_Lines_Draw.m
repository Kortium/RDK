function laser_model=Laser_Lines_Draw(laser_lines)
    laser_model=zeros(2,length(laser_lines)*3);
    for i=1:length(laser_lines)
        laser_model((i-1)*3+1,1) = laser_lines(1,1,i);
        laser_model((i-1)*3+1,2) = laser_lines(1,2,i);
        
        laser_model((i-1)*3+2,1) = laser_lines(2,1,i);
        laser_model((i-1)*3+2,2) = laser_lines(2,2,i);
        
        laser_model((i-1)*3+3,1) = laser_lines(1,1,i);
        laser_model((i-1)*3+3,2) = laser_lines(1,2,i);
    end
end