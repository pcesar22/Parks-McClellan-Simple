function makePlot(w,h)

maxval = max(h);
minval = min(h);

figure();
plot(w/pi,h,'LineWidth',1.4)
set(gca,'XTick',0:.1:1);
set(gca,'YLim',[minval-0.1 ,maxval+0.2 ]);
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude')

end