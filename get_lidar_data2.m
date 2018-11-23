lds = rossubscriber('/scan', 'BufferSize', 5);
lds_temp = receive(lds);
lds_data = readCartesian(lds_temp);
[angles,ranges] = cart2pol(lds_data(:,1), lds_data(:,2));
deg_ran = [angles*180/pi,ranges];
ld = ones(length(lds_data),1);
range = 1.5;
label=zeros(60,2);
ind=zeros(60,1);
newd=zeros(60,1);
index=1;
sixty = zeros(60,3);
for i = 1:30
    sixty(i,1) = deg_ran(31-i,1);
    sixty(i,2) = deg_ran(31-i,2);
    sixty(i,3) = i;
end
for i = 1:30
    sixty(i+30,1) = deg_ran(length(deg_ran)-i+1,1);
    sixty(i+30,2) = deg_ran(length(deg_ran)-i+1,2);
    sixty(i+30,3) = i+30;
end
for i=1:59
    label(index,1) = index;
    label(index,2) = label(index,2)+1;
    ind(1) = sixty(1,1);   
    if abs(sixty(i,2)-sixty(i+1,2)) > 0.05
         index=index+1;
         ind(index)=sixty(i+1,1);
         newd(index) = sixty(i+1,3);
    end
end

figure(5);
x_lidar = lds_data(:,1);
y_lidar = lds_data(:,2);
plot(x_lidar,y_lidar,'o', 'Color','blue');
grid;
axis([-(range+0.01) range+0.01 -(range+0.01) range+0.01])

new_label = zeros(index,3);
new_ind = ones(index,2);
for i=1:index
    new_label(i,1) = label(i,1);
    new_label(i,2) = label(i,2);
    new_label(i,3) = i;
    new_ind(i,1) = ind(i);
    new_ind(i,2) = newd(i);
end
disp(sixty)
disp(new_label);
disp(new_ind);
length(lds_data)