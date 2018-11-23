function [ binary_image ] = ball_detection(color_image) % 반환값 = 함수(인자). 컬러이미지를 받아 흑백이미지로 반환하는 함수.  
%UNTITLED 이 함수의 요약 설명 위치
%   자세한 설명 위치
[R, C, ~] = size(color_image);  
binary_image = zeros(R,C);  %R,C 사이즈 이미지 맵을 만듬. 
color=30;
for row=1:R
    for col=1:C
        if color_image(row,col,1) < color && color_image(row,col,2) < color && color_image(row,col,3) < color
               binary_image(row,col)=255;    %백.       
        else
               binary_image(row,col)=0;      %흑.
        end    
    end
end