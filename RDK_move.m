function [RDK] = RDK_move (RDK, V, w,dt)
    RDK.theta = pi_to_pi(RDK.theta + w*dt);
    RDK.x = RDK.x + V*cos(RDK.theta)*dt;
    RDK.y = RDK.y + V*sin(RDK.theta)*dt;
end