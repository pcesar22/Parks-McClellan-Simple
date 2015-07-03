% Checks specifications for lowpass filter

% h - magnitude response (regular)
% w - frequency values (non-normalized)
% limits - [wp,ws,maxpbgain, minpbgain, sbgain]

function c = checkLimits(w,h,limits)

    wp = limits(1)*pi;
    ws = limits(2)*pi;
    maxpbgain = limits(3);
    minpbgain = limits(4);
    maxsbgain = limits(5);
    
    isValid = 1;
    
    for i = 1:length(w)
        if(w(i) <= wp)
            if(h(i) > maxpbgain | h(i) < minpbgain)
                isValid = 0;
            end
        else if (w(i) >= ws)
                if(h(i) > maxsbgain)
                    isValid = 0;
                end
            end
        end
    end
    
    if(isValid) disp('PASSED. The filter response meets the required specifications');
    else disp('FAILED. The filter response does not meet the required specifications');
    end
    
    c = isValid;



end