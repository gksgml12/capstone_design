function [path, arrive] = PathPlanning2(start_x, start_y, end_x, end_y, ogrid)
arrive=true;
%map Inflate
robotRadius = 0.15;
mapInflated = copy(ogrid);
% setOccupancy(mapInflated,[start_x start_y],0);
inflate(mapInflated,robotRadius);

figure(3)
show(mapInflated)

%PRM path
prm = robotics.PRM;
prm.Map = mapInflated;
prm.NumNodes = 400;
prm.ConnectionDistance = 1;

%location
startLocation = [start_x start_y];
endLocation = [end_x end_y];
disp(checkOccupancy(mapInflated, endLocation));
disp(checkOccupancy(mapInflated, startLocation));
if checkOccupancy(mapInflated, endLocation) ~= 0
    mp;
% elseif checkOccupancy(mapInflated, endLocation) == 1
%     arrive=false;
end
if checkOccupancy(mapInflated, startLocation) ~= 0
    mp2;
end
disp(endLocation);
disp(startLocation);
%path
path = findpath(prm, startLocation, endLocation)
figure(2)
show(prm)
end