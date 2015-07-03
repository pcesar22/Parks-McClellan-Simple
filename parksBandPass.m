% Generate a band-pass Parks McClellan FIR filter
% All values are normalized from 0-1
% Written by Paulo Costa 04/15

ws1 = 0.16; % end first stopband frequency    
wp1 = 0.22; % start passband frequency
wp2 = 0.76; % end passband frequency
ws2 = 0.83; % start second stopband frequency

ds1 = 0.08; % deviation for first stopband
dp = 0.04;  % deviation for passband
ds2 = 0.08; % deviation for second stopband

% Vectors for the firpmord function
F = [ ws1 wp1 wp2 ws2];
A = [0  1  0]; 
DEV = [ds1 dp ds2];

W = [1 1 1]; % Weighting parameters for the remez algorithm.
% These parameters tell you how much each deviation matters 
% in the algorithm

% Get the approximate order for the Park McClellan optimal equiripple FIR
[N,Fo,Ao,W] = firpmord(F,A,DEV);

% Make sure N is even
if( mod(N,2) ~= 0) 
    N = N+1; 
end

b = firpm(N,Fo,Ao,W);
[h,wresp] = getAmplitude(b);
limits = [ws1 wp1 wp2 ws2]; % I know, its =F, but for clarity

% While filter does not meet required specifications
while (~bandPassCheckLimits(wresp,h,limits,DEV))
    N = N+2;
    disp(['Trying order N = ', num2str(N), ' .... ']);
    b = firpm(N,Fo,Ao,W);
    [h,wresp] = getAmplitude(b);
end




%% Make Plots and display the constraints

% Make the filter response of the acquired filter
makePlot(wresp,h);
hold on

xpoints = [0 wp1 ws2 wp1 0 ws2; ws1 wp2 1 wp2 ws1 1];
ypoints = [ds1 1+dp ds2 1-dp -ds1 -ds2 ; ds1 1+dp ds2 1-dp -ds1 -ds2];

xpoints2 = [wp1 ws1 wp2 ws2; wp1 ws1 wp2 ws2];
ypoints2 = [-0.3 -0.3 -0.3 -0.3 ; 1.2 1.2 1.2 1.2];

plot(xpoints,ypoints,'r:','LineWidth',1.8);
plot(xpoints2,ypoints2,'g:','LineWidth', 1.2);


