% limits - [wp,ws,maxpbgain_db, minpbgain_db, sbgain_db]
% wp and ws are normalized from 0-1

function [b,k] = parksFIR(limits)

wp = limits(1);
ws = limits(2);
maxpbgain_db = limits(3);
minpbgain_db = limits(4);
sbgain_db = limits(5);
    
%% Constants used

maxpbgain = 10^(maxpbgain_db/20);
minpbgain = 10^(minpbgain_db/20);
sbgain = 10^(sbgain_db/20); 

% Scaling the parameters to fit the iir model (max gain of 1);
devFIRpb = (maxpbgain-minpbgain)/(maxpbgain+minpbgain)
k = maxpbgain/(maxpbgain+devFIRpb)
devFIRsb = sbgain/k

%% Estimate order of PM filter

f = [wp,ws]; % vector of band frequencies

% The vector m contains the
% desired magnitude response values at the passbands and the stopbands of the filter. Since
% a lowpass filter consists of a passband followed by a stopband, m has two entires. Namely,
% m=[1 0] because you would like the magnitude response to be equal to 1 in the passband
% and equal to 0 in the stopband.

m = [ 1 ,0];

% The vector dev has the maximum allowable deviations of
% the magnitude response of the filter from the desired magnitude response. It has the same
% number of entries as there are m. Thus, for a low-pass filter it has two entries and is equal
% to [passband ripple, stopband ripple].

dev = [devFIRpb,devFIRsb];

[n,fo,mo,w] = firpmord(f,m,dev);
b = firpm(n,fo,mo,w);
% Append 0 if function is even lengthed (this is a bad fix)
if(mod(length(b),2) == 0) b = [b,0];  end

[h,wresp] = getAmplitude(b);



while ~checkLimits(wresp,k*h,limits) %makes sure the response is in desired bounds
   n = n + 1;
   
   disp(['testing n = ...  ', num2str(n)]);
   b = firpm(n,fo,mo,w);
   % Append 0 if function is even lengthed (this is a bad fix)
   if(mod(length(b),2) == 0) b = [b,0];  end
   [h,wresp] = getAmplitude(b);
   
end 




end