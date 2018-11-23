A = ones(60,60);
B=zeros(121);
C=zeros(60);
for i=-60:60
    B(i+61,61)=abs(i);
    B(61,i+61)=abs(i);
    B(i+61,i+61)=abs(i);
    B(i+61,-i+61)=abs(i);
end
for i=1:60
    for j=1:60
    C(61-i,61-j)=B(i+(round(10*end_x)/10)*40,j+(round(10*end_y)/10)*40);
    end
end

for i=1:1:60
    for j=1:1:60
        x=[i*0.025 j*0.025];
        %A(16-j,i) = checkOccupancy(mapInflated,x);
        A(i,j) = checkOccupancy(mapInflated,x);
    end
end

A = A==0;
D = A.*C;
D(D==0) = 100;
m = min(min(D));
D(D==m) = 100;
m = min(min(D));
D(D==m) = 100;
m = min(min(D));
D(D==m) = 100;
m = min(min(D));

for i=1:1:60
    for j=1:1:60
        if D(i,j)==m
            new_index_x = i;
            new_index_y = j;
        end
    end
end

end_x = new_index_x*0.025;
end_y = new_index_y*0.025;
endLocation=[end_x end_y];
for i = 0:1:1
    for j = 0:1:1
        setOccupancy(mapInflated,[end_x+i*0.025 end_y+j*0.025],0);
        setOccupancy(mapInflated,[start_x+i*0.025 start_y+j*0.025],0); 
    end
end
show(mapInflated);