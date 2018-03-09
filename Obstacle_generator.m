% Файл для создания массива с препятствиями

function Obstacle_generator
    obstacles = [];
    traj_points = [];
    i=1;
    j=1;
    angle = 0;

    f = figure('Visible','off','Name','Create obstacles GUI','NumberTitle','off');
    ax = axes('Units', 'normalized', 'Position', [0.05 0.2 0.9 0.7]);
    ax.XLim = [-10 10];
    ax.YLim = [-10 10];
    axis equal
    grid on
    
    % Set obstacle
    uicontrol('Style', 'pushbutton', 'String', 'Set Obstacle',...
        'Units', 'normalized','Position', [0.05 0.05 0.2 0.1],...
        'Callback', @Set_Obstacle);
   
    % Set traj point
    uicontrol('Style', 'pushbutton', 'String', 'Set Trajectory Point',...
        'Units', 'normalized','Position', [0.35 0.05 0.2 0.1],...
        'Callback', @Set_TrajPoint);
    
    % Exit
    uicontrol('Style', 'pushbutton', 'String', 'Im finished',...
        'Units', 'normalized','Position', [0.65 0.05 0.2 0.1],...
        'Callback', @Get_Out);
    % Type of obstacle selection
    SelectionGroup = uibuttongroup('Visible','on',...
                                    'Position',[0 0.91 0.5 1]);
    SquareSelect = uicontrol(SelectionGroup,'Style',...
                  'radiobutton',...
                  'String','Square',...
                  'Position',[40 5 100 30],...
                  'HandleVisibility','on');
    TriangleSelect = uicontrol(SelectionGroup,'Style',...
                  'radiobutton',...
                  'String','Triangle',...
                  'Position',[120 5 100 30],...
                  'HandleVisibility','on');
    RectangleSelect = uicontrol(SelectionGroup,'Style',...
                  'radiobutton',...
                  'String','Rectangle',...
                  'Position',[200 5 100 30],...
                  'HandleVisibility','on');
    f.Visible = 'on';
    AngleSelect = uicontrol('Style','edit','String','0',...
        'HandleVisibility','on','Position',[350 387 100 30]);
    
    
    
    function Set_Obstacle(source, event)
        dot = ginput(1);
        obstacles(i).x = dot(1);
        obstacles(i).y = dot(2);
        obstacles(i).theta = 0.01745*str2double(get(AngleSelect,'String'));
%Obstacle type 1 -- Square
%         type 2 -- Triangle
%         type 3 -- Rectangle
        if SquareSelect.Value == true
            model = Square_graph_model(obstacles(i));
            obstacles(i).Type = 1;
        end
        if TriangleSelect.Value == true
            model = Big_triangle_graph_model(obstacles(i));
            obstacles(i).Type = 2;
        end
        if RectangleSelect.Value == true
            model = Rectangle_graph_model(obstacles(i));
            obstacles(i).Type = 3;
        end
        line(ax,model(:,1), model(:,2),'color','r','linewidth',5);
        ax.XLim = [-10 10];
        ax.YLim = [-10 10];
        axis equal
        grid on
%         angle = angle+pi/11;
        i = i+1;
    end

    function Set_TrajPoint(source, event)
        dot = ginput(1);
        traj_points(j,1) = dot(1);
        traj_points(j,2) = dot(2);
        line(ax,traj_points(:,1), traj_points(:,2),'color','g','linewidth',2);
        ax.XLim = [-10 10];
        ax.YLim = [-10 10];
        axis equal
        grid on
        j = j+1;
    end

    function Get_Out(source, event)
        assignin('base','obstacles',obstacles);
        assignin('base','trajPoints',traj_points);
        close(f);
    end
end