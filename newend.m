a=0.2;
if checkOccupancy(mapInflated,endLocation)~=0
    newend_x = end_x+a;
    newend_y = end_y;
    endLocation = [newend_x newend_y]
end
if checkOccupancy(mapInflated,endLocation)~=0
    newend_x = newend_x-a;
    newend_y = newend_y+a;
    endLocation = [newend_x newend_y]
end
if checkOccupancy(mapInflated,endLocation)~=0
    newend_x = newend_x-a;
    newend_y = newend_y-a;
    endLocation = [newend_x newend_y]
end
if checkOccupancy(mapInflated,endLocation)~=0
    newend_x = newend_x+a;
    newend_y = newend_y-a;
    endLocation = [newend_x newend_y]
end