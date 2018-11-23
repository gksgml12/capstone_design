robot = rospublisher('/cmd_vel');
velmsg = rosmessage(robot);
odom = rossubscriber('/odom');
k=0;
lds = rossubscriber('/scan');
min_distance=100;
lds_temp = receive(lds);
lds_data = readCartesian(lds_temp);
for i=1:10000
    
    x1=1;
    y1=1;

    odomdata = receive(odom,3);
    pose = odomdata.Pose.Pose;
    x = pose.Position.X;
    y = pose.Position.Y;
    z = pose.Position.Z;
     
    quat = pose.Orientation;
    eul = quat2eul([quat.W quat.X quat.Y quat.Z]);
    yaw = eul(1);
    
    for j=1:length(lds_data)
        distance=sqrt((lds_data(j,1)-x)^2 + (lds_data(j,2)-y)^2);
        if min_distance>distance
            min_distance=distance;
        end
    end
        
    if min_distance<0.25&&k==0
        k=1;
        ObstacleAvoidance(robot, velmsg);
    else
        rho = sqrt((x1-x)^2+(y1-y)^2);
        theta = atan2(y1-y,x1-x);
        alpha = atan2(sin(theta-yaw),cos(theta-yaw));
        beta = -alpha-yaw;
        r = [rho alpha beta]
    
        if abs(r(2))>0.25
            v = 0.075*r(1);
            w = 3.2*r(2) - 0.15*r(3);
        else
            v = 0.6*r(1);
            w = 0.1*r(2) - 0.075*r(3);
        end
        v=sat(v,0.2);
        w=sat(w,0.5);
        isDT=thr(r(1),0.05);
        isAT=thr(r(2),0.05);
        if isDT==1
            v=0;
            w=0;
            break;
        end
        if isAT==1
            v=0.2;
            w=0;
        end
        u=[v,w]
    end
    velmsg.Linear.X = v;
    velmsg.Angular.Z = w;
    disp([velmsg.Linear.X velmsg.Angular.Z]);
    
    send(robot,velmsg);
end
velmsg.Linear.X = v;
velmsg.Angular.Z = w;
send(robot,velmsg);