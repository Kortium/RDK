function Bigtriangle = Big_triangle_graph_model (Object)
    base = [-0.6,-1.2;-0.6,1.2;1.8,0;-0.6,-1.2];
    angle = Object.theta;
    DCM = [cos(angle) sin(angle); -sin(angle) cos(angle)];
    base = base*DCM;
    Bigtriangle(1,:) = [base(1,1)+Object.x, base(1,2)+Object.y];
    Bigtriangle(2,:) = [base(2,1)+Object.x, base(2,2)+Object.y];
    Bigtriangle(3,:) = [base(3,1)+Object.x, base(3,2)+Object.y];
    Bigtriangle(4,:) = [base(4,1)+Object.x, base(4,2)+Object.y];
    Bigtriangle(5,:) = [base(1,1)+Object.x, base(1,2)+Object.y];
end