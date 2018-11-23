function [alpha, detect_flag] = compute_input()  %인자형만 지정해놓음.  흑백처리된 이미지를 가져옴. 
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

image_temp = receive(sub_image);  %토픽에서 받아오는 부분.
image_temp.Format = 'bgr8;jpeg/compressed/bgr8';
ref_img = readImage(image_temp);   %readImage 함수. 왜 필요한가?
object_img = ball_detection(ref_img);   %ball detection으로 흑백처리한 이미지 가져옴.
% remove all object containing fewer than 500 pixels
bw = bwareaopen(object_img,1000);

[~, C] = size(bw);       %좌, 우의 값만 사용하고 있으므로. 
[x, ~] = ball_position(bw);  %흑백처리한 이미지인 object_img로 중심좌표를 계산해 가져옴. 
disp(C);
disp(x);
if(C/2 == x)
    angle = 90; %정확히 중심일 경우 아래에서 w = 0이 됨. 
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