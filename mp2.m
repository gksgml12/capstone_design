A=ones(60,60);
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
    C(61-i,61-j)=B(i+(round(10*start_x)/10)*40,j+(round(10*start_y)/10)*40);
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

for i=1:1:60
    for j=1:1:60
        if D(i,j)==m
            new_index_x = i;
            new_index_y = j;
        end
    end
end

start_x = new_index_x*0.025;
start_y = new_index_y*0.025;
startLocation=[start_x start_y];