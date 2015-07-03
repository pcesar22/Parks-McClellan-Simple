function makePlot(w,h)

figure();
plot(w/pi,h,'LineWidth',1.4)
set(gca,'XTick',0:.1:1);
set(gca,'YLim',[-0.2 1.2]);
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude')

end