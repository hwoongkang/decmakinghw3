function plotEx()
figure;

x1 = 0;
x2 = 2;

y1 = 0;
y2 = 2*tan(pi/5);

s1 = 1;

s2 = 0.5;

y1Temp = s1*(x2-x1)+y1;
y2Temp = s2*(x1-x2) + y2;

[xMid, yMid] = polyxpoly([x1,x2],[y1,y1Temp],[x2,x1],[y2,y2Temp]);

xx1 = linspace(x1,xMid);
yy1 = s1*(xx1-x1)+y1;

xx2 = linspace(x2,xMid);
yy2 = s2*(xx2-x2) + y2;

f1 = quiver(0,0,xMid,yMid,0,'k','LineWidth',1.2);
hold on;
quiver(xMid,yMid,x2-xMid,y2-yMid,0,'k','LineWidth',1.2);
f2= plot([x1,x2],[y1,y2],'--k');

legend([f2,f1],{"Required Direction","Approximation"})

axis equal
xlim([-0.1,2.1])
ylim([-0.1,y2+0.1])

xticks(0:0.5:2);
yticks(0:0.5:2);
grid on;

end