robot = rospublisher('/cmd_vel');
velmsg = rosmessage(robot);

ref_size = 24099;   %���� ������.
ref_distance = 15;  %���� �Ÿ�. 
f_detect_flag= 0 ; % ���� detect_flag
f_alpha =0;
left_flag=0;
right_flag=0;

%for i=1:10000
    [alpha, detect_flag] = compute_input();%��Ʋ���� �νĵǾ�����.
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