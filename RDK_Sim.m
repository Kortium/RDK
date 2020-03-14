function RDK_Sim(obstacles, showlaser, trajectory)
	%Comment
    initime = cputime;
    RDK = RDK_class;
    point_id = 1;

    dt = 0.1;
    rays = 180;
    model_steps = 200000;
    Ray_length = 17;
    model = Triangle_graph_model(RDK);
    if nargin > 2
        traj = trajectory;
        RDK.targetX = traj(point_id,1);
        RDK.targetY = traj(point_id,2);
    else
        traj = [0,0;6,3];
    end
    
    f = figure('Visible','on','Name','RDK sim','NumberTitle','off');
    ax4 = axes('Units', 'normalized', 'Position', [0.1 0.1 0.8 0.8]);
    
    axes(ax4)
    ax4.XLim = [-20 20];
    ax4.YLim = [-20 20];
    fsa.x = [];
    fsa.y = [];
    hold on
    RDK_collision_plot = plot(ax4,model(:,1), model(:,2),'b','linewidth',3);
    Init_obstacles(obstacles, ax4);
    target_line = plot(ax4,0,0,'LineStyle','--','Color','g','linewidth',2);
    foot_step = plot(ax4,0,0,'m','linewidth',3);
    axis equal
    grid on
    
    distance = zeros(model_steps,rays);
    Vx = zeros(1,model_steps);
    Vy = zeros(1,model_steps);
    for i = 1:model_steps
        %measurement
        [laser_lines, measured_distance] = Measure_laser(RDK, obstacles, rays, Ray_length);
        distance(i,:) = measured_distance;
        if nargin > 1 && showlaser
            laser_model = Laser_Lines_Draw(laser_lines);
        end
        measure_model = Measure_draw(laser_lines, Ray_length);
        
        [RDK.Avoiding_obstacle, RDK.Avoiding_heading, avoiding_point] = Collision_avoid(RDK,measured_distance);
        if RDK.Avoiding_obstacle || RDK.Avoiding_heading
            RDK.workAroundX = avoiding_point(1);
            RDK.workAroundY = avoiding_point(2);
        else
            RDK.Avoiding_obstacle = false;
            RDK.Avoiding_heading = false;
        end
        
        %check target
        if point_reached(RDK)
            point_id = point_id+1;
            if (point_id>length(traj))
                point_id = 1;
                break
            end
            RDK.targetX = traj(point_id,1);
            RDK.targetY = traj(point_id,2);
        end
        
        %control
        [V,w] = Regulator (RDK);

        %use of control
        RDK=RDK.move(V, w, dt);
        
        %draw
        model = Triangle_graph_model(RDK);
        set(RDK_collision_plot,'xdata',model(:,1),'ydata', model(:,2));
        if ~RDK.Avoiding_obstacle && ~RDK.Avoiding_heading
            set(target_line,'xdata',trajectory(:,1),'ydata', trajectory(:,2));
        else
            set(target_line,'xdata',[RDK.x, RDK.workAroundX, RDK.x, RDK.targetX],'ydata', [RDK.y, RDK.workAroundY, RDK.y, RDK.targetY]);
        end
        set(foot_step,'xdata',fsa.x,'ydata',fsa.y)
        drawnow
        %RDK speed projections on X and Y axes.
        %The first line of "projections" matrix is X-projections
        %The second line is Y-projections
        Vx(i) = V*cos(RDK.theta);
        Vy(i) = V*sin(RDK.theta);
        Vproj = [Vx;Vy];
%         pause(0.1);
    end
    assignin('base','projections',Vproj)
    assignin('base','distance',distance)
    load handel
    fintime = cputime;
    fprintf('CPUTIME: %g\n', fintime - initime);
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
    if n_obstacles>=1
        for i=1:n_obstacles
            x1 = measured_obstacles(i).points(1,1);
            y1 = measured_obstacles(i).points(1,2);
            set(plots(i),'xdata',[measured_obstacles(i).points(:,1);x1],'ydata',[measured_obstacles(i).points(:,2);y1]);
        end
    end
end

function result = point_reached(RDK)
    dist = sqrt((RDK.x-RDK.targetX)^2 +(RDK.y-RDK.targetY)^2);

    if dist < 0.5
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
    




