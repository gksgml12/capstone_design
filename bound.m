x=[0.01:0.01:1.5]';
y=zeros(length(x),1);
z=[x y];
setOccupancy(mapInflated,z,1);

x=[0.01:0.01:1.5]';
y=1.5*ones(length(x),1);
z=[x y];
setOccupancy(mapInflated,z,1);

y=[0.01:0.01:1.5]';
x=zeros(length(x),1);
z=[x y];
setOccupancy(mapInflated,z,1);

y=[0.01:0.01:1.5]';
x=1.5*ones(length(x),1);
z=[x y];
setOccupancy(mapInflated,z,1);