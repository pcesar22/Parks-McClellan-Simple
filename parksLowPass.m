% Generate a low-pass Parks McClellan FIR filter
% All frequency values are normalized from 0-1
% Written by Paulo Costa 04/15

%% Establish low-pass filter parameters << EDIT HERE! >>

wp = 0.4;
ws = 0.6;
maxpbgain = 1.01;
minpbgain = 0.99;
maxsbgain = 0.05;


%% Obtain the filter response

limits = [wp,ws,maxpbgain,minpbgain,maxsbgain];
[b,wresp,h] = parksFIR(limits);


%% Make Plots and display the constraints

% Make the filter response of the acquired filter
makePlot(wresp,h);
hold on

% Passband delimiters
xpoints = [ 0  , 0 ;
            wp , wp ];
ypoints = [ minpbgain, maxpbgain ; 
            minpbgain, maxpbgain ];

% Stopband delimiters
xpoints2 = [ ws ws ;
            1  1];
ypoints2 = [ maxsbgain -maxsbgain ; 
            maxsbgain -maxsbgain];
        
% Frequency delimiters
xpoints3 = [ws,  wp;
            ws,  wp];
ypoints3 = [-maxsbgain - 0.2, -maxsbgain-0.2;
            maxpbgain + 0.2, maxpbgain+0.2];

% Plot!
plot(xpoints,ypoints,'g:','LineWidth',1.8);
plot(xpoints2,ypoints2,'r:','LineWidth',1.8);
plot(xpoints3,ypoints3,'m:','LineWidth',1.8);



