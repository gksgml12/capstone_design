function detect = ball_size(image)
%UNTITLED4 �� �Լ��� ��� ���� ��ġ
%�ڼ��� ���� ��ġ
[R, C] = size(image);
object_size = 0;

for row=1:R
    for col=1:C   
        value = image(row,col);
        if value ~= 0                    
            object_size = object_size + 1;
        end
    end
end
if object_size > 1 
    detect = 1;
else 
    detect = 0;
end