function [center_x, center_y] = ball_position(image)  %���ó���� �̹����� �޾� �߽���ǥ�� ��ȯ���ִ� �Լ�. 
%UNTITLED2 �� �Լ��� ��� ���� ��ġ
%�ڼ��� ���� ��ġ
[R, C] = size(image); %�̹��� ���� ������ �� �ȼ������� ��Ŀ� ����.
x_min = 3000;   %����.
x_max = 0;
y_min = 3000;
y_max = 0;
for row=1:R
    for col=1:C   
        value = image(row,col);     %���ó���� �̹����� ������. ��Ļ�����. 
        if value ~= 0                    %value�� 0�� �ƴϸ�, �� ����̸�. %Saturation �κ�.
            if x_min > col               %col�� x_min���� ������. %col�� ���� ��. 
                x_min = col;
            end
            if x_max < col              %������ ��������鼭 �����.
                x_max = col;            %���� ���� ������ ��������. 
            end
            if y_min > row
                y_min = row;
            end
            if y_max < row
                y_max = row;
            end        
        end
    end
end

center_x = (x_min + x_max)/2;
center_y = (y_min + y_max)/2;
end