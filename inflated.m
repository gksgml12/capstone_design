robotRadius = 0.13;
mapInflated = copy(ogrid);
% setOccupancy(mapInflated,[start_x start_y],0);
inflate(mapInflated,robotRadius);
