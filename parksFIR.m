% limits - [wp,ws,maxpbgain_db, minpbgain_db, sbgain_db]
% wp and ws are normalized from 0-1

%b is the filter response
% wresp and h are the frequency x amplitude values used to plot 
function [b,wresp,h] = parksFIR(limits)

wp = limits(1);
ws = limits(2);
maxpbgain = limits(3);
minpbgain = limits(4);
maxsbgain = limits(5);
    

% Scaling the parameters to fit the iir model (max gain of 1);
devFIRpb = (maxpbgain-minpbgain)/(maxpbgain+minpbgain);
k = maxpbgain/(maxpbgain+devFIRpb);
devFIRsb = maxsbgain/k;

%% Estimate order of PM filter

F = [wp,ws]; % vector of band frequencies

% The vector A contains the
% desired magnitude response values at the passbands and the stopbands of the filter. Since
% a lowpass filter consists of a passband followed by a stopband, m has two entires. Namely,
% A =[1 0] because you would like the magnitude response to be equal to 1 in the passband
% and equal to 0 in the stopband.

A = [1 0];

% The vector dev has the maximum allowable deviations of
% the magnitude response of the filter from the desired magnitude response. It has the same
% number of entries as there are m. Thus, for a low-pass filter it has two entries and is equal
% to [passband ripple, stopband ripple].

DEV = [devFIRpb,devFIRsb];

% Estimate the approximate order of the filter
[N,Fo,Mo,W] = firpmord(F,A,DEV);

%Make sure N is even
if( mod(N,2) ~= 0) 
    N = N+1; 
end

b = firpm(N,Fo,Mo,W);
[h,wresp] = getAmplitude(b);

% Increase order of the filter until it meets required specifications
while ~lowPassCheckLimits(wresp,h,limits) %makes sure the response is in desired bounds
   N = N + 2;
   
   disp(['Trying order N = ', num2str(N),  ' .... ']);
   b = firpm(N,Fo,Mo,W);
   [h,wresp] = getAmplitude(b);
   
end 




end