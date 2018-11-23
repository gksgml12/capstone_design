function [path, arrive] = PathPlanning3(start_x, start_y, end_x, end_y, ogrid)
arrive=true;
%map Inflate
pathflag = 1;
for i = 0:1:2
    for j = 0:1:2
        setOccupancy(ogrid,[start_x+i*0.0125 start_y+j*0.0125],0); 
    end
end
robotRadius = 0.13;
mapInflated = copy(ogrid);
inflate(mapInflated,robotRadius);
setflag = 1;
while(pathflag ==1)
% setOccupancy(mapInflated,[start_x start_y],0);
mapInflated2 =copy(mapInflated);
%PRM path
%location
startLocation = [start_x start_y];
endLocation = [end_x end_y];
% disp(checkOccupancy(mapInflated, endLocation));
disp("startLocation의 상태 : "+checkOccupancy(mapInflated, startLocation));
if checkOccupancy(mapInflated2, endLocation) == -1
    mp4;
elseif checkOccupancy(mapInflated2, endLocation) == 1
    mp4;
end
if setflag == 1
    for i = 0:1:8
    for j = 0:1:8
        setOccupancy(mapInflated2,[end_x-0.025+i*0.0125 end_y-0.025+j*0.0125],0);
        %disp([end_x+i*0.01,end_y+j*0.01]);
        setOccupancy(mapInflated2,[start_x+i*0.0125 start_y+j*0.0125],0); 
    end
    end
    setflag = 0;
end
disp("endLocation의 상태 : "+checkOccupancy(mapInflated2, endLocation));
disp("startLocation : "+startLocation);
disp("endLocation : "+endLocation);
%path
prm = robotics.PRM;
prm.Map = mapInflated2;
prm.NumNodes = 400;
prm.ConnectionDistance = 1;
% figure(2)
% show(mapInflated2)
path = findpath(prm, startLocation, endLocation)
pathflag=0;
if isempty(path)==1
    disp('재설정')
    pathflag = 1;
    checkoc;
    for i = -2*maxt1:1:2*maxt3
        for j = -2*maxt2:1:2*maxt4
        setOccupancy(mapInflated,[end_x+(i)*0.0125 end_y+(j)*0.0125],1);
        end
    end
    figure(3);
    show(mapInflated)
    figure(5)
    show(mapInflated2)
    setflag = 1;
    continue;
end    
end
figure(3)
show(prm)
end