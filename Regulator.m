function [V,w] = Regulator(RDK)
    x = RDK.targetX - RDK.x;
    y = RDK.targetY - RDK.y;
    V = 1;
    w = 0.2;
end