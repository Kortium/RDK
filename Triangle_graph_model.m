function triangle = Triangle_graph_model (Object)
    base = [-0.5,-1;-0.5,1;1.5,0;-0.5,-1];
    angle = Object.theta;
    DCM = [cos(angle) sin(angle); -sin(angle) cos(angle)];
    base = base*DCM;
    triangle(1,:) = [base(1,1)+Object.x, base(1,2)+Object.y];
    triangle(2,:) = [base(2,1)+Object.x, base(2,2)+Object.y];
    triangle(3,:) = [base(3,1)+Object.x, base(3,2)+Object.y];
    triangle(4,:) = [base(4,1)+Object.x, base(4,2)+Object.y];
end