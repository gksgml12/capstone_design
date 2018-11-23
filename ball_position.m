function [center_x, center_y] = ball_position(image)  %흑백처리된 이미지를 받아 중심좌표를 반환해주는 함수. 
%UNTITLED2 이 함수의 요약 설명 위치
%자세한 설명 위치
[R, C] = size(image); %이미지 파일 내부의 각 픽셀값들을 행렬에 넣음.
x_min = 3000;   %수정.
x_max = 0;
y_min = 3000;
y_max = 0;
for row=1:R
    for col=1:C   
        value = image(row,col);     %흑백처리된 이미지를 가져옴. 행렬사이즈. 
        if value ~= 0                    %value가 0이 아니면, 즉 백색이면. %Saturation 부분.
            if x_min > col               %col이 x_min보다 작을때. %col이 행이 됨. 
                x_min = col;
            end
            if x_max < col              %값들이 덮어씌워지면서 실행됨.
                x_max = col;            %가장 작은 값들이 남아있음. 
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