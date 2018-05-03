function sqare = Rectangle_graph_model(Object)
    base = [-2.5 -3; 2.5 -3; 2.5 3; -2.5 3;-2.5 -3];
    angle = -Object.theta;
    DCM = [cos(angle) sin(angle); -sin(angle) cos(angle)];
    base = base*DCM;
    sqare(1,:) = [base(1,1)+Object.x, base(1,2)+Object.y];
    sqare(2,:) = [base(2,1)+Object.x, base(2,2)+Object.y];
    sqare(3,:) = [base(3,1)+Object.x, base(3,2)+Object.y];
    sqare(4,:) = [base(4,1)+Object.x, base(4,2)+Object.y];
    sqare(5,:) = [base(5,1)+Object.x, base(5,2)+Object.y];
end