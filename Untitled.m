x1 = 2; %���κ��� ���� ��ġ
y1 = 2;
x2 = 2; %���� �޾ƿ� ���κ��� ��ġ
y2 = 1;
t = 1;
v = sqrt(2);
w = pi/4;
mx1 = 0; %odom���� ������ �ʱ� �츮 ��ġ
my1 = 0;
mx2 = 1; %odom���� ���� ������ �츮 ���� ��ġ
my2 = 1;
mx3 = v*cos(w)*t; %���� �ӵ��� ���� ������ �츮 ���� ��ġ
my3 = v*sin(w)*t;
me = 0;
x1 = x1 + mx1; %������ ������ �ʱ� ��ġ
y1 = y1 + my1;
x2 = x2 + mx2; %������ ������ ���� ��ġ
y2 = y2 + my2;
vr = sqrt(((x2-x1)/t)^2+((y2-y1)/t)^2)/t
erd = (acos((x2-x1)/(vr*t)))*180/pi
err = (asin((y2-y1)/(vr*t)))

A = [ 1 0 -vr*sin(err)*t ; 0 1 vr*cos(err)*t ; 0 0 1 ];
B = [ cos(err)*t 0; sin(err)*t 0; 0 t ];
[mx3 my3 0]'-(A*[mx2-x2 my2-y2 err-me]' + B*[v-vr w-err/t]')