function ObstacleAvoidance( robot, velmsg)

    velmsg.Linear.X = 0;
    velmsg.Angular.Z = pi/2;
    tic; 
    while toc < 0.25
        send(robot, velmsg);
    end
    
    velmsg.Linear.X = 0.1;
    velmsg.Angular.Z = -0.3;
    tic; 
    while toc < 5
        send(robot, velmsg);
    end
    
    velmsg.Linear.X = 0;
    velmsg.Angular.Z = pi/2;
    tic; 
    while toc < 0.25
        send(robot, velmsg);
    end
end