kkk=1;
position = [0.2 0.8];
i=1;
j=3;
arrive=true;

%handles and objects
handles.odomSub = rossubscriber('/odom', 'BufferSize', 25);
handles.laserSub = rossubscriber('/scan', 'BufferSize', 5);
handles.velPub = rospublisher('/cmd_vel');
MsgVel = rosmessage(handles.velPub);
plotobj = ExampleHelperTurtleBotVisualizer([-3,3,-3,3]);
ogrid = robotics.OccupancyGrid(1.5,1.5,40);
r = robotics.Rate(10);
reset(r);

while(arrive)
    %odometry
    receive(handles.odomSub);
    [pose(1),pose(2),pose(3)]=getPose(handles.odomSub);
    if i==12
        if kkk==1
            kkk=0;
            [path, arrive] = PathPlanning3(pose(1)+0.01,pose(2)+0.01,position(1,1),position(1,2),ogrid);
            last_pose = [path(length(path),1) path(length(path),2)];
        else
            [path, arrive] = PathPlanning3(last_pose(1,1),last_pose(1,2),position(1,1),position(1,2),ogrid);
            last_pose = [path(length(path),1) path(length(path),2)];
        end
    elseif i>13
        if j==length(path)-1
            j=j+1;
        end
        x = path(j,1);
        y = path(j,2);
        num1(x,y);
        if j==length(path)
            i=0;
            j=2;
            stop;
        end
        j=j+1;
    end

    receive(handles.odomSub);
    [pose(1),pose(2),pose(3)]=getPose(handles.odomSub);
    pose(1)=pose(1);
    pose(2)=pose(2);
    pose(3)=pose(3);
    
    MsgScan=receive(handles.laserSub);

    %occupancy grid
    ogridpose=[pose(1)+0.01 pose(2)+0.01 pose(3)];
    insertRay(ogrid, ogridpose, lidarScan(MsgScan), 10);

    figure(1)
    show(ogrid);
    figure(1)
    rectangle('Position',[ogridpose(1)-0.075 ogridpose(2)-0.075 0.15 0.15],'Curvature',[0.1 0.1])

    %laserscan with pose
    laserData = readCartesian(handles.laserSub.LatestMessage) * [0 1; -1 0];

    waitfor(r);
    i=i+1;
    time = r.TotalElapsedTime;
    fprintf('-----------------------------------------\n');
    fprintf('Iteration: %d - Time Elapsed: %f\n',i,time);
    fprintf('X= %f Y=%f theta=%f\n',pose(1),pose(2),pose(3));
    if sqrt((pose(1)-position(1,1))^2+(pose(2)-position(1,2))^2)<0.05
        arrive=false;
    end
end