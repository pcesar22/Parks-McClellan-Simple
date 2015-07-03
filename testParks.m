% Parks-McClellan design of FIR Low Pass filters

% The example used will have the specifications:

% max passband gain = 0dB
% min passband gain = -1dB
% stopband attenuation = 50dB
% wpass = 0.10714 (normalized 0-pi --> 0-1)
% wstop = 0.17857

%% Constants used

wp = 0.30714;
ws = 0.55857;
maxpbgain_db = 0; 
minpbgain_db = -1; 
sbgain_db = -30; 

sbgain = 10^(sbgain_db/20);
minpbgain = 10^(minpbgain_db/20);
maxpbgain = 10^(maxpbgain_db/20);

limits = [wp,ws,maxpbgain_db, minpbgain_db, sbgain_db];

m = [1, 0];
%% Find the filter response with the specified limits

% To change the order of the filter response, edit the parksFIR function
[b,k] = parksFIR(limits);

%% Plot the result

[h,w] = freqz(b,m,'half');


plot(w/pi,20*log10(abs(k*h)),'LineWidth',1.1)
set(gca,'XTick',0:.1:1);
set(gca,'YLim',[sbgain_db-20 10]);
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')

% set visual limits
hold on

xpoints = [0 0; wp wp];
ypoints = [minpbgain_db maxpbgain_db; minpbgain_db maxpbgain_db];

plot(xpoints,ypoints,'g');
plot([ws; 1],[sbgain_db;sbgain_db],'r');
grid on
%% Check if the response meets the desired specifications

limits = [wp, ws, maxpbgain_db, minpbgain_db, sbgain_db];
%checkLimits(w,k*h,limits);

%% Plot linear
figure();
% [phi, w] = phasez(b,m,'half');
% q = unwrap(angle(h));
% angleornot = (( (q<=0) - 0.5)*2);
plot(w/pi,abs(k*h),'LineWidth',1.1)
set(gca,'XTick',0:.1:1);
set(gca,'YLim',[-0.05 1.1]);
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude')

% set visual limits
hold on

xpoints = [0 0; wp wp];
ypoints = [minpbgain maxpbgain; minpbgain maxpbgain];

plot(xpoints,ypoints,'g');
plot([ws; 1],[sbgain;sbgain],'r');
plot([ws; 1],[-sbgain;-sbgain],'r');



