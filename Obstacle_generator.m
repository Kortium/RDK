function Obstacle_generator
    obstacles = [];
    i=1;
    angle = 0;

    f = figure('Visible','off','Name','Create obstacles GUI','NumberTitle','off');
    ax = axes('Units', 'normalized', 'Position', [0.05 0.2 0.9 0.7]);
    ax.XLim = [-10 10];
    ax.YLim = [-10 10];
    axis equal
    grid on
    
   % Create push button
    uicontrol('Style', 'pushbutton', 'String', 'Set Obstacle',...
        'Units', 'normalized','Position', [0.05 0.05 0.3 0.1],...
        'Callback', @Set_Obstacle);
    
   % Create push button
    uicontrol('Style', 'pushbutton', 'String', 'Im finished',...
        'Units', 'normalized','Position', [0.65 0.05 0.3 0.1],...
        'Callback', @Get_Out);
    
    f.Visible = 'on';
    
    
    
    function Set_Obstacle(source, event)
        dot = ginput(1);
        obstacles(i).x = dot(1);
        obstacles(i).y = dot(2);
        obstacles(i).theta = angle;
        model = Square_graph_model(obstacles(i));
        line(ax,model(:,1), model(:,2),'color','r','linewidth',5);
        ax.XLim = [-10 10];
        ax.YLim = [-10 10];
        axis equal
        grid on
        angle = angle+pi/11;
        i = i+1;
    end

    function Get_Out(source, event)
        assignin('base','obstacles',obstacles);
        close(f);
    end
end