robot = rospublisher('/cmd_vel');
velmsg = rosmessage(robot);

ref_size = 24099;   %참고 사이즈.
ref_distance = 15;  %참고 거리. 
f_detect_flag= 0 ; % 전의 detect_flag
f_alpha =0;
left_flag=0;
right_flag=0;

%for i=1:10000
    [alpha, detect_flag] = compute_input();%터틀봇이 인식되었을시.
    if f_detect_flag == 1 && detect_flag ==0
        if f_alpha  < 0
           left_flag = 1;
           right_flag = 0;
        else
           right_flag = 1;
           left_flag = 0;
        end
    elseif f_detect_flag==1 && detect_flag==1
        right_flag = 0;
        left_flag = 0;
    else
        f_detect_flag = detect_flag;
        f_alpha = alpha;
    end
%end