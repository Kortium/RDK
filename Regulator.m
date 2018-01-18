function [V,w] = Regulator(RDK)
    x = RDK.targetX - RDK.x;
    y = RDK.targetY - RDK.y;
    
    distance_to_target = sqrt(x^2 +y^2);
    
    hct = atan2(y,x);
    
    d_heading = pi_to_pi(hct - RDK.theta);

    if abs(d_heading)<(3/180)*pi
        w = 0;
    else
        w = 0.05*sign(d_heading) + d_heading*0.35/pi;
    end
    
    V_dist = distance_to_target*heading_k(d_heading)*0.07;
    if V_dist>0.15
        V = 0.6;
    else
        V = 0.05*sign(pi/2 - d_heading) + V_dist*sign(pi/2-d_heading);
    end
end

function angle = pi_to_pi(value)
    while value<=-pi || value>pi
        if value < -pi
            value = value+2*pi;
        elseif value >= pi
            value = value-2*pi;
        end
    end
    angle = value;
end

function heading_k = heading_k(value)
    if value>=0
		heading_k = exp(3.26*(-value));
    else
		heading_k = exp(3.26*value);
    end
end