ibvs_gazebo;
alpha = -(alpha-9);
get_lidar_data;
deg_ran;
x=0;
s=0;
for i=1:length(new_ind)-1
    if new_ind(i)>=alpha&&new_ind(i+1)<=alpha
        x=i+1;
        s=s+new_label(i,2);
    end
end
sum=0;
aa=s;
bb=s+new_label(x,2)-1;
for i=aa:1:bb
    sum = sum + sixty(i,2);
end
average_dis = sum/new_label(x,2);
disp(average_dis);