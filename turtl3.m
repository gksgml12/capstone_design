%SLAM program
clc;
%Declare Variables
position = [1.2 0.2; 1.2 1.2 ;0.2 1.2];
%poseHistory=[];

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
j=3;
f=0;
i=1;
time=0;
while(breakcondition(i,time))
    %odometry
    receive(handles.odomSub);
    [pose(1),pose(2),pose(3)]=getPose(handles.odomSub);
    if i==17
        if kkk==1 
            path = PathPlanning2(pose(1)+0.05,pose(2)+0.05,position(kkk,1),position(kkk,2),ogrid);
        else
            path = PathPlanning2(pose(1),pose(2),position(kkk,1),position(kkk,2),ogrid);
        end
    elseif i>18&&f==0
        if j==length(path)-1
            j=j+1;
        end
        x = path(j,1);
        y = path(j,2);
        num1(x,y);
        if j==length(path)
            f=1;
            stop;
        end
        j=j+1;
    end

    receive(handles.odomSub);
    [pose(1),pose(2),pose(3)]=getPose(handles.odomSub);
    pose(1)=pose(1);
    pose(2)=pose(2);
    pose(3)=pose(3);
    
    %local laserscan
    MsgScan=receive(handles.laserSub);

    %occupancy grid
    ogridpose=[pose(1)+0.01 pose(2)+0.01 pose(3)];%theta];
    insertRay(ogrid, ogridpose, lidarScan(MsgScan), 10);

    figure(1)
    show(ogrid);
    figure(1)
    rectangle('Position',[ogridpose(1)-0.075 ogridpose(2)-0.075 0.15 0.15],'Curvature',[0.1 0.1])

    %laserscan with pose
    laserData = readCartesian(handles.laserSub.LatestMessage) * [0 1; -1 0];
%     plotData(plotobj,pose,laserData);

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