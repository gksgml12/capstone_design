t1 =1;
t2 =1;
t3 =1;
t4 =1;
while(true)
    if D(new_index_x-t1,new_index_y) == 100
        maxt1 = t1;
        break;
    end
    t1 = t1+1;
end
while(true)
    if D(new_index_x,new_index_y-t2) == 100
        maxt2 = t2;
        break;
    end
    t2 = t2+1;
end
while(true) 
    if D(new_index_x+t3,new_index_y) == 100
        maxt3 = t3;
        break;
    end
    t3 = t3+1;
end
while(true)
if D(new_index_x,new_index_y+t4) == 100
        maxt4 = t4;
        break;
end
t4 = t4+1;
end
disp(maxt1)
disp(maxt2)
disp(maxt3)
disp(maxt4)
   