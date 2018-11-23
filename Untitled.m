x1 = 2; %상대로봇의 이전 위치
y1 = 2;
x2 = 2; %새로 받아온 상대로봇의 위치
y2 = 1;
t = 1;
v = sqrt(2);
w = pi/4;
mx1 = 0; %odom으로 측정한 초기 우리 위치
my1 = 0;
mx2 = 1; %odom으로 측정 가능한 우리 현재 위치
my2 = 1;
mx3 = v*cos(w)*t; %현재 속도를 통해 예측한 우리 다음 위치
my3 = v*sin(w)*t;
me = 0;
x1 = x1 + mx1; %상대방의 절대적 초기 위치
y1 = y1 + my1;
x2 = x2 + mx2; %상대방의 절대적 현재 위치
y2 = y2 + my2;
vr = sqrt(((x2-x1)/t)^2+((y2-y1)/t)^2)/t
erd = (acos((x2-x1)/(vr*t)))*180/pi
err = (asin((y2-y1)/(vr*t)))

A = [ 1 0 -vr*sin(err)*t ; 0 1 vr*cos(err)*t ; 0 0 1 ];
B = [ cos(err)*t 0; sin(err)*t 0; 0 t ];
[mx3 my3 0]'-(A*[mx2-x2 my2-y2 err-me]' + B*[v-vr w-err/t]')