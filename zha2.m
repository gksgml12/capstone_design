function C=zha2(x,y)
    B=zeros(121);
    C=zeros(60);
    for i=-60:60
        B(i+61,:)=abs(i);
        B(:,i+61)=abs(i);
        B(-i+61,:)=abs(i);
        B(:,-i+61)=abs(i);
        %B(61,61)=0
    end
    for i=1:60
        for j=1:60
            C(61-i,61-j)=B(i+(round(10*end_x)/10)*40,j+(round(10*end_y)/10)*40);
        end
    end
end