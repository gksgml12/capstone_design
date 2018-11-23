odomSub= rossubscriber('/odom');
velPub = rospublisher('/cmd_vel');
MsgVel = rosmessage(velPub);
[x,y,theta] = getPose(odomSub);
ibvs_gazebo;
% alpha = -alpha-9;
alpha=-alpha;
get_lidar_data2;
deg_ran;
j=0;
for i=1:length(new_ind)-1
    if new_ind(i,1)>=alpha&&new_ind(i+1,1)<=alpha
        j=i+1;
    end
end
sum=0;
aa=new_ind(j,2);
bb=new_ind(j,2)+new_label(j,2)-1;
for i=aa:1:bb
    sum = sum + sixty(i,2);
end
average_dis = sum/new_label(j,2);
disp(average_dis);
xr=x+average_dis*cos((alpha+theta)*pi/180);
yr=y+average_dis*sin((alpha+theta)*pi/180);
position = [xr yr]
% turtl4;