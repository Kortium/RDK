function RDK_Sim(obstacles)
    RDK.x = 5;
    RDK.y = -6;
    RDK.theta = pi/4;
    V = 1;
    w = 0.2;
    dt = 0.1;
    rays = 360;
    model = Triangle_graph_model(RDK);
    
    f = figure('Visible','on','Name','RDK move','NumberTitle','off');
    ax = axes('Units', 'normalized', 'Position', [0.1 0.1 0.8 0.8]);
    ax.XLim = [-10 10];
    ax.YLim = [-10 10];
    axis equal
    grid on
    RDK_plot = plot(ax,model(:,1), model(:,2),'b','linewidth',3);
    hold on
%     Laser_plot = plot(ax,0, 0,'g','linewidth',1,'MarkerSize',10);

    Init_obstacles(obstacles, ax);
    for i = 1:1000
        %measurement
%         laser_lines = Measure_laser(RDK, obstacles, rays);
%         laser_model = Laser_Lines_Draw(laser_lines);
        
        %control

        %use of control
        RDK = RDK_move(RDK, V, w, dt);
        %draw
        model = Triangle_graph_model(RDK);
        set(RDK_plot,'xdata',model(:,1),'ydata', model(:,2));
%         set(Laser_plot,'xdata',laser_model(:,1),'ydata', laser_model(:,2));
        drawnow
        ax.XLim = [-10 10];
        ax.YLim = [-10 10];
        axis equal
        grid on
%         pause(0.1);
    end
end




