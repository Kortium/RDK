function Init_obstacles(obstacles,plot)
    for i = 1:length(obstacles)
        if obstacles(i).Type == 1
            model = Square_graph_model(obstacles(i));
            squares = line(plot,model(:,1), model(:,2),'color','r','linewidth',2);
        end
        if obstacles(i).Type == 2
            model = Big_triangle_graph_model(obstacles(i));
            squares(i) = line(plot,model(:,1), model(:,2),'color','r','linewidth',2);
        end
        if obstacles(i).Type == 3
            model = Rectangle_graph_model(obstacles(i));
            squares(i) = line(plot,model(:,1), model(:,2),'color','r','linewidth',2);
        end
    end
end