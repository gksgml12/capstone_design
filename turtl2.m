%SLAM program
clc;
position = [0.4 0.1; 0.7 0.7; 0.2 1.4];
%Declare Variables

poseHistory=[];

%handles and objects
handles.odomSub = rossubscriber('/odom', 'BufferSize', 25);
handles.laserSub = rossubscriber('/scan', 'BufferSize', 5);
handles.velPub = rospublisher('/cmd_vel');
MsgVel = rosmessage(handles.velPub);
plotobj = ExampleHelperTurtleBotVisualizer([-7,7,-7,7]);
ogrid = robotics.OccupancyGrid(1.5,1.5,40);
r = robotics.Rate(10);
reset(r);

%waypoints
% receive(handles.odomSub);
% [ipose(1),ipose(2),ipose(3)]=getPose(handles.odomSub);
% dist=1;
% wp=[ipose(1)+dist*cos(ipose(3)), ipose(2)+dist*sin(ipose(3))];


for kkk=1:3
j=1;
f=0;
i=1;
time=0;
while(breakcondition(i,time))
    %odometry
    receive(handles.odomSub);
    [pose(1),pose(2),pose(3)]=getPose(handles.odomSub);
    if i==15
        path = PathPlanning2(pose(1)+0.01,pose(2)+0.01,position(kkk,1),position(kkk,2),ogrid);
    elseif i>20&&f==0
        x = path(j,1);
        y = path(j,2);
        num1(x,y);
        if j==length(path)
            f=1;
        end
        j=j+1;
    end

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
    ogridpose=[pose(1)+0.01 pose(2)+0.01 pose(3)];%theta];
    insertRay(ogrid, ogridpose, lidarScan(MsgScan), 10);

    figure(3)
    show(ogrid);
    figure(3)
    rectangle('Position',[ogridpose(1)-0.075 ogridpose(2)-0.075 0.15 0.15],'Curvature',[0.1 0.1])

    %laserscan with pose
    laserData = readCartesian(handles.laserSub.LatestMessage) * [0 1; -1 0];
    plotData(plotobj,pose,laserData);

%     %controlleruuu
%     [linvel,angvel]=controller(pose,MsgScan,wp);
% 
%     %mover
%     mover(handles.velPub,MsgVel,linvel,angvel);

    waitfor(r);
    i=i+1;
    time = r.TotalElapsedTime;
    fprintf('-----------------------------------------\n');
    fprintf('Iteration: %d - Time Elapsed: %f\n',i,time);
    fprintf('X= %f Y=%f theta=%f\n',pose(1),pose(2),pose(3));
end
end