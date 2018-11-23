function num1(x1, y1)
robot = rospublisher('/cmd_vel');
velmsg = rosmessage(robot);

odom = rossubscriber('/odom');

for i=1:10000
    
    odomdata = receive(odom,3);
    pose = odomdata.Pose.Pose;
    x = pose.Position.X;
    y = pose.Position.Y;
    z = pose.Position.Z;

    quat = pose.Orientation;
    eul = quat2eul([quat.W quat.X quat.Y quat.Z]);
    yaw = eul(1);

    rho = sqrt((x1-x)*(x1-x)+(y1-y)*(y1-y));
    theta = atan2(y1-y,x1-x);
    alpha = atan2(sin(theta-yaw),cos(theta-yaw));
    beta = -alpha-yaw;
    r = [rho alpha beta];
    
    if abs(r(2))>0.25
        v = 0.3*r(1);
        w = 3.2*r(2) - 0.15*r(3);
    else
        %v = 0.6*r(1);
        v = 0.2;
        w = 0.1*r(2) - 0.075*r(3);
    end
    v=sat(v,0.2);
    w=sat(w,2.5);
    isDT=thr(r(1),0.03);
    isAT=thr(r(2),0.05);
    if isDT==1
%           v=0;
%           w=0;
        break;
    end
     if isAT==1
         v=0.2;
         w=0;
     end
    velmsg.Linear.X = v;
    velmsg.Angular.Z = w;
%    disp([velmsg.Linear.X velmsg.Angular.Z]);

    send(robot,velmsg);
end
velmsg.Linear.X = v;
velmsg.Angular.Z = w;
send(robot,velmsg);
end