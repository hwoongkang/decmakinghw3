function plotEx()
figure;
y2 = 0;
for i=0:0.1:0.9
	x1 = linspace(i,i+0.06);
	y1 = 0.5*(x1-x1(1)) + y2(end);
	x2 = linspace(i+0.06, i+0.1);
	y2 = y1(end) + 0*x2;
	f1=plot(x1,y1,'--k');
	hold on;
	plot(x2,y2,'--k');
end
x = linspace(0,1);
f2=plot(x,0.3*x,'k');
axis equal
xlim([-0.1,1.1]);
ylim([-0.05,0.35]);
plot(0,0,'ok')
plot(1,0.3,'^k')
legend([f1,f2], ["Approximated", "Desired"])
title("Approximation of a Trajectory")
grid on;
end