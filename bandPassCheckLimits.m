function isValid = bandPassCheckLimits(w,h,limits,dev)

% limits = [ws1 wp1 wp2 ws2];
% dev = [ds1 dp ds2];

    ws1= limits(1)*pi;
    wp1 = limits(2)*pi;
    wp2 = limits(3)*pi;
    ws2 = limits(4)*pi;
    
    ds1 = dev(1);
    dp = dev(2);
    ds2 = dev(3);
    
    isValid = 1;
    
    for i = 1:length(w)
       if(w(i) <= ws1)
           isValid = ((h(i) <= ds1) && (h(i)>= -ds1));
       else if ((w(i) >= wp1) && (w(i) <= wp2)) 
               isValid = ((h(i) >= 1-dp )&& (h(i) <= 1+dp));
           else if(w(i) >= ws2)
                   isValid = (( h(i) <= ds2) && (h(i) >= -ds2));
               end
           end
       end
       if(isValid == 0)
           break;
       end
    end
    
    if(isValid) disp('PASSED. The filter response meets the required specifications');
    else disp('FAILED. The filter response does not meet the required specifications');
    end
end