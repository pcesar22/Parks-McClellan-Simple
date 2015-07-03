% Generate a band-pass Parks McClellan FIR filter
% All frequency values are normalized from 0-1
% Written by Paulo Costa 04/15

%%  Establish band-pass filter parameters << EDIT HERE! >>

ws1 = 0.16; % end first stopband frequency    
wp1 = 0.22; % start passband frequency
wp2 = 0.76; % end passband frequency
ws2 = 0.83; % start second stopband frequency

ds1 = 0.08; % deviation for first stopband
dp = 0.04;  % deviation for passband
ds2 = 0.08; % deviation for second stopband

%% Obtain filter response

% Vectors for the firpmord function
F = [ ws1 wp1 wp2 ws2];
A = [0  1  0]; 
DEV = [ds1 dp ds2];

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

% Passband delimiters
xpoints = [ wp1 wp1 ; 
            wp2 wp2 ];
ypoints = [1-dp , 1+dp;
           1-dp , 1+dp];
       
% Stopband delimiters
xpoints2 = [0 0 ws2 ws2;
            ws1 ws1 1 1];
ypoints2 = [-ds1 ds1 -ds1 ds1 ;
            -ds2 ds2 -ds2 ds2];

% Frequency delimiters
xpoints3 = [ws1 wp1 wp2 ws2;
            ws1 wp1 wp2 ws2];
ypoints3 = [-ds1-0.2 , -ds1-0.2 , -ds1-0.2 , -ds1-0.2  ;
            1+dp+0.2, 1+dp+0.2 ,1+dp+0.2 ,1+dp+0.2 ];

% Plot!
plot(xpoints,ypoints,'g:','LineWidth',1.8);
plot(xpoints2,ypoints2,'r:','LineWidth', 1.8);
plot(xpoints3,ypoints3,'m:','LineWidth', 1.2);



