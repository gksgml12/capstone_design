function [alpha, detect_flag] = compute_input()  %�������� �����س���.  ���ó���� �̹����� ������. 
clc;
% rgb camera topic
if ismember('/raspicam_node/image/compressed', rostopic('list'))
    sub_image = rossubscriber('/raspicam_node/image/compressed');
    disp('sucessfully connect to RGB camera');
else
    disp('failure to connect to RGB camera');
end
% robot moving control topic
robot = rospublisher('/cmd_vel');
% velmsg = rosmessage(robot);

image_temp = receive(sub_image);  %���ȿ��� �޾ƿ��� �κ�.
image_temp.Format = 'bgr8;jpeg/compressed/bgr8';
ref_img = readImage(image_temp);   %readImage �Լ�. �� �ʿ��Ѱ�?
object_img = ball_detection(ref_img);   %ball detection���� ���ó���� �̹��� ������.
% remove all object containing fewer than 500 pixels
bw = bwareaopen(object_img,1000);

[~, C] = size(bw);       %��, ���� ���� ����ϰ� �����Ƿ�. 
[x, ~] = ball_position(bw);  %���ó���� �̹����� object_img�� �߽���ǥ�� ����� ������. 
disp(C);
disp(x);
if(C/2 == x)
    angle = 90; %��Ȯ�� �߽��� ��� �Ʒ����� w = 0�� ��. 
else
    angle = atan(525/((C/2)-x)); %focal length
    angle = angle * 180 / 3.1415; % degree
    if angle < 0
        angle = angle +180;
    end
end
disp(angle)
detect_flag = ball_size(bw);
alpha = angle - 90;
disp(alpha)
figure(1);
imshow(ref_img);

figure(2);
imshow(bw);