function safe=breakcondition(t,time)
    globalStopIteration=100;
    globalStopTime=150;
    safe=false;
    if(t>globalStopIteration)
        safe= false;
    elseif(time>globalStopTime)
        safe= false;
    else 
        safe= true;
    end
end
    