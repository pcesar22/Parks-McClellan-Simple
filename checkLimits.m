% Checks specifications

% h - magnitude response (regular)
% w - frequency values (non-normalized)
% limits - [wp,ws,maxpbgain_db, minpbgain_db, sbgain_db]

function c = checkLimits(w,h,limits)

    wp = limits(1)*pi;
    ws = limits(2)*pi;
    maxpbgain_db = limits(3);
    minpbgain_db = limits(4);
    sbgain_db = limits(5);
    
    h = 20*log10(abs(h));
    
    isValid = 1;
    
    for i = 1:length(w)
        if(w(i) <= wp)
            if(h(i) > maxpbgain_db | h(i) < minpbgain_db)
                isValid = 0;
            end
        else if (w(i) >= ws)
                if(h(i) > sbgain_db)
                    isValid = 0;
                end
            end
        end
    end
    
    if(isValid) disp('PASSED. The filter response meets the specifications');
    else disp('FAILED. The filter response doesnt meet the required specifications');
    end
    
    c = isValid;



end