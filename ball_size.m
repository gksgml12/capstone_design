function detect = ball_size(image)
%UNTITLED4 이 함수의 요약 설명 위치
%자세한 설명 위치
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