%SLAM program
clc;

%Declare Variables
i=1;
time=0;
poseHistory=[];

%handles and objects
handles.odomSub = rossubscriber('/odom', 'BufferSize', 25);
handles.laserSub = rossubscriber('/scan', 'BufferSize', 5);
handles.velPub = rospublisher('/cmd_vel');
MsgVel = rosmessage(handles.velPub);
plotobj = ExampleHelperTurtleBotVisualizer([-7,7,-7,7]);
ogrid = robotics.OccupancyGrid(1.5,1.5,20);
r = robotics.Rate(10);
reset(r);

%waypoints
receive(handles.odomSub);
[ipose(1),ipose(2),ipose(3)]=getPose(handles.odomSub);
dist=1;
wp=[ipose(1)+dist*cos(ipose(3)), ipose(2)+dist*sin(ipose(3))];

while(breakcondition(i,time))
    %odometry
    receive(handles.odomSub);
    [pose(1),pose(2),pose(3)]=getPose(handles.odomSub);
    pose(1)=pose(1);
    pose(2)=pose(2);
    poseHistory=[poseHistory;pose];
    distance(i)=sqrt((poseHistory(i,1)-poseHistory(1,1))^2+(poseHistory(i,2)-poseHistory(1,2))^2);

    %local laserscan
    MsgScan=receive(handles.laserSub);
    figure(1)
    plot(MsgScan)
    title('Local Map')
    text(9.5,10,['X = ',num2str(pose(1)),' Y = ',num2str(pose(2)),' Th = ',num2str(pose(3))])
    drawnow

    %occupancy grid
    ogridpose=[pose(1)-ipose(1)+0.1 pose(2)-ipose(2)+0.1 pose(3)];%theta];
    insertRay(ogrid, ogridpose, lidarScan(MsgScan), 10);
    figure(3)
    show(ogrid);
    figure(3)
    rectangle('Position',[ogridpose(1)-0.2 ogridpose(2)-0.1 0.2 0.2],'Curvature',[0.1 0.1])

    %laserscan with pose
    laserData = readCartesian(handles.laserSub.LatestMessage) * [0 1; -1 0];
    plotData(plotobj,pose,laserData);

    %controller
    [linvel,angvel]=controller(pose,MsgScan,wp);

    %mover
    mover(handles.velPub,MsgVel,linvel,angvel);

    waitfor(r);
    i=i+1;
    time = r.TotalElapsedTime;
    fprintf('-----------------------------------------\n');
    fprintf('Iteration: %d - Time Elapsed: %f\n',i,time);
    fprintf('X= %f Y=%f theta=%f\n',pose(1),pose(2),pose(3));
end
mover(handles.velPub, MsgVel, 0, pi/2);
pause(1);
mover(handles.velPub, MsgVel, 0, 0);
receive(handles.odomSub);
[ipose(1),ipose(2),ipose(3)]=getPose(handles.odomSub);
dist=1;
wp=[ipose(1)+dist*cos(ipose(3)), ipose(2)+dist*sin(ipose(3))];
i=1;
time=0;
while(breakcondition(i,time))
    %odometry
    receive(handles.odomSub);
    [pose(1),pose(2),pose(3)]=getPose(handles.odomSub);
    pose(1)=pose(1);
    pose(2)=pose(2);
    poseHistory=[poseHistory;pose];
    distance(i)=sqrt((poseHistory(i,1)-poseHistory(1,1))^2+(poseHistory(i,2)-poseHistory(1,2))^2);

    %local laserscan
    MsgScan=receive(handles.laserSub);
    figure(1)
    plot(MsgScan)
    title('Local Map')
    text(9.5,10,['X = ',num2str(pose(1)),' Y = ',num2str(pose(2)),' Th = ',num2str(pose(3))])
    drawnow

    %occupancy grid
    ogridpose=[pose(1)-ipose(1)+0.1 pose(2)-ipose(2)+0.1 pose(3)];%theta];
    insertRay(ogrid, ogridpose, lidarScan(MsgScan), 10);
    figure(3)
    show(ogrid);
    figure(3)
    rectangle('Position',[ogridpose(1)-0.2 ogridpose(2)-0.1 0.2 0.2],'Curvature',[0.1 0.1])

    %laserscan with pose
    laserData = readCartesian(handles.laserSub.LatestMessage) * [0 1; -1 0];
    plotData(plotobj,pose,laserData);

    %controller
    [linvel,angvel]=controller(pose,MsgScan,wp);

    %mover
    mover(handles.velPub,MsgVel,linvel,angvel);

    waitfor(r);
    i=i+1;
    time = r.TotalElapsedTime-15;
    fprintf('-----------------------------------------\n');
    fprintf('Iteration: %d - Time Elapsed: %f\n',i,time);
    fprintf('X= %f Y=%f theta=%f\n',pose(1),pose(2),pose(3));
end