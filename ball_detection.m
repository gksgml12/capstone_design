function [ binary_image ] = ball_detection(color_image) % ��ȯ�� = �Լ�(����). �÷��̹����� �޾� ����̹����� ��ȯ�ϴ� �Լ�.  
%UNTITLED �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
[R, C, ~] = size(color_image);  
binary_image = zeros(R,C);  %R,C ������ �̹��� ���� ����. 
color=30;
for row=1:R
    for col=1:C
        if color_image(row,col,1) < color && color_image(row,col,2) < color && color_image(row,col,3) < color
               binary_image(row,col)=255;    %��.       
        else
               binary_image(row,col)=0;      %��.
        end    
    end
end