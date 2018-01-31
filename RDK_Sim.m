function RDK_Sim(obstacles, showlaser, trajectory)
	%Comment
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
    ax = axes('Units', 'normalized', 'Position', [0.05 0.05 0.4 0.4]);
    ax2 = axes('Units', 'normalized', 'Position', [0.05 0.55 0.4 0.4]);
    ax3 = axes('Units', 'normalized', 'Position', [0.55 0.05 0.4 0.4]);
    
    axes(ax2)
    obstacle_plots(1) = plot(ax2,0,0,'r');
    hold on
    ax2.XLim = [-20 20];
    ax2.YLim = [-15 15];
    axis equal
    grid on
    
    axes(ax3)
    [cx, cy] = circle(0, 0, Ray_length);
    plot(cx, cy, 'Color',[0.6 0.6 0.6],'linewidth',3);
    hold on
    tri.x = 0;
    tri.y = 0;
    tri.theta = 0;
    tri.model = Triangle_graph_model(tri);
    plot(cx, cy, 'Color',[0.6 0.6 0.6]);
    plot(tri.model(:,1),tri.model(:,2),'b','linewidth',3);
    measure_plot = scatter(ax3,0,0,'.','r');
    ax3.XLim = [-Ray_length*1.1 Ray_length*1.1];
    ax3.YLim = [-Ray_length*1.1 Ray_length*1.1];
    axis equal
    grid on
    
    axes(ax)
    ax.XLim = [-20 20];
    ax.YLim = [-15 15];
    RDK_plot = plot(ax,model(:,1), model(:,2),'b','linewidth',3);
    axis equal
    grid on
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
        measure_model = Measure_draw(laser_lines, Ray_length);
        measured_obstacles = Find_obstacles(measure_model);
        measured_obstacles = Join_obstacles(measured_obstacles);
        measured_obstacles = Sort_obstacles(measured_obstacles);
        measured_obstacles = Convert_obstacle(RDK, measured_obstacles);
        
%         move_collisions = Collision_detection(RDK,measured_obstacles);
        
        
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
        
        obstacle_plots = plot_measured_obstacles(measured_obstacles, ax2, obstacle_plots);
        ax2.XLim = [-20 20];
        ax2.YLim = [-15 15];
        set(measure_plot,'xdata',measure_model(:,1),'ydata', measure_model(:,2));

        drawnow
%         pause(0.1);
    end
end

function plots = plot_measured_obstacles(measured_obstacles, axes, plots)
    n_obstacles = length(measured_obstacles);
    n_plots = length(plots);
    for i = 1:n_plots
        set(plots(i),'xdata',[0,0],'ydata',[0,0]);
    end
    if (n_plots<n_obstacles)
        for i = n_plots:n_obstacles
            plots(i) = plot(axes,0,0,'r');
        end
    end
    for i=1:n_obstacles
        set(plots(i),'xdata',measured_obstacles(i).points(:,1),'ydata',measured_obstacles(i).points(:,2));
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
    




