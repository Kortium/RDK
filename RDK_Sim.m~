function RDK_Sim(obstacles, showlaser, trajectory)
    RDK.x = -6;
    RDK.y = -6;
    RDK.targetX = 0;
    RDK.targetY = 0;
    RDK.theta = -pi/4;
    point_id = 1;
    V = 1;
    w = 0.2;
    dt = 0.1;
    rays = 360;
    Ray_length = 7;
    model = Triangle_graph_model(RDK);
    if nargin > 2
        traj = trajectory;
        RDK.targetX = traj(point_id,1);
        RDK.targetY = traj(point_id,2);
    else
        traj = [0,0;6,3];
    end
    
    f = figure('Visible','on','Name','RDK move','NumberTitle','off');
    ax = axes('Units', 'normalized', 'Position', [0.1 0.1 0.35 0.8]);
    ax2 = axes('Units', 'normalized', 'Position', [0.55 0.1 0.35 0.8]);
    axes(ax)
    ax.XLim = [-20 20];
    ax.YLim = [-15 15];
    axis equal
    grid on
    axes(ax2)
    [cx, cy] = circle(0, 0, Ray_length);
    plot(cx, cy, 'Color',[0.6 0.6 0.6],'linewidth',3);
    hold on
    tri.x = 0;
    tri.y = 0;
    tri.theta = pi/2;
    tri.model = Triangle_graph_model(tri);
    plot(cx, cy, 'Color',[0.6 0.6 0.6]);
    plot(tri.model(:,1),tri.model(:,2),'b','linewidth',3);
    measure_plot = scatter(ax2,0,0,'.','r');
    ax2.XLim = [-Ray_length*1.1 Ray_length*1.1];
    ax2.YLim = [-Ray_length*1.1 Ray_length*1.1];
    axis equal
    grid on
    axes(ax)
    RDK_plot = plot(ax,model(:,1), model(:,2),'b','linewidth',3);
    if nargin > 1 && showlaser
        hold on;
        Laser_plot = plot(ax,0, 0,'g','linewidth',1,'MarkerSize',10);
    end

    Init_obstacles(obstacles, ax);
    for i = 1:10000
        %measurement
        laser_lines = Measure_laser(RDK, obstacles, rays, Ray_length);
        if nargin > 1 && showlaser
            laser_model = Laser_Lines_Draw(laser_lines);
        end
        
        %check target
        if point_reached(RDK)
            point_id = rem(point_id,length(traj))+1;
            RDK.targetX = traj(point_id,1);
            RDK.targetY = traj(point_id,2);
        end
        
        %control
        [V,w] = Regulator (RDK);

        %use of control
        RDK = RDK_move(RDK, V, w, dt);
        
        %draw
        model = Triangle_graph_model(RDK);
        set(RDK_plot,'xdata',model(:,1),'ydata', model(:,2));
        if nargin > 1 && showlaser
            set(Laser_plot,'xdata',laser_model(:,1),'ydata', laser_model(:,2));
        end
        ax.XLim = [-20 20];
        ax.YLim = [-15 15];
        axis equal
        grid on
        axes(ax2)
        measure_model = measure_draw(laser_lines, Ray_length);
        set(measure_plot,'xdata',measure_model(:,1),'ydata', measure_model(:,2));
        axis equal
        grid on
        drawnow
%         pause(0.1);
    end
end

function result = point_reached(RDK)
    dist = sqrt((RDK.x-RDK.targetX)^2 +(RDK.y-RDK.targetY)^2);

    if dist < 0.005
        result = true;
    else
        result = false;
    end
end

function [xunit, yunit] = circle(x,y,r)
    th = 0:pi/50:2*pi;
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
end
    




