function Init_obstacles(obstacles,plot)
    for i = 1:length(obstacles)
        model = Square_graph_model(obstacles(i));
        squares(i)= line(plot,model(:,1), model(:,2),'color','r','linewidth',5);
    end
end