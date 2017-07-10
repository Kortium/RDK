function RDK_Sim(obstacles)
    RDK.x = 5;
    RDK.y = -6;
    RDK.theta = pi/4;
    V = 1;
    w = 0.3;
    dt = 0.1;
    model = Triangle_graph_model(RDK);
    
    f = figure('Visible','on','Name','RDK move','NumberTitle','off');
    ax = axes('Units', 'normalized', 'Position', [0.1 0.1 0.8 0.8]);
    ax.XLim = [-10 10];
    ax.YLim = [-10 10];
    axis equal
    grid on
    RDK_plot = plot(ax,model(:,1), model(:,2),'b','linewidth',5);
    hold on
    Laser_plot = plot(ax,0, 0,'g','linewidth',1);

    Init_obstacles(obstacles, ax);
    for i = 1:300
        %measurement
        laser_lines = Measure_laser(RDK, obstacles);
        laser_model = Laser_Lines_Draw(laser_lines);
        
        %control

        %use of control
        RDK = RDK_move(RDK, V, w, dt);
        %draw
        model = Triangle_graph_model(RDK);
        set(RDK_plot,'xdata',model(:,1),'ydata', model(:,2));
        set(Laser_plot,'xdata',laser_model(:,1),'ydata', laser_model(:,2));
        drawnow
        ax.XLim = [-10 10];
        ax.YLim = [-10 10];
        axis equal
        grid on
%         pause(0.1);
    end
end




