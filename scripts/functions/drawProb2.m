function drawProb2()
figure;
x = linspace(-7,7);
y = 7*ones(1,100);
plot(x,y,'k','LineWidth',1.5)
hold on;
plot(x,-y,'k','LineWidth',1.5)
plot(y,x,'k','LineWidth',1.5)
plot(-y,x,'k','LineWidth',1.5)
xx = linspace(-40,40);
yy= zeros(1,100);
plot(xx,yy,':k','LineWidth',0.3)
plot(yy,xx,':k','LineWidth',0.3)
axis equal
xlim([-10,10]);
ylim([-10,10]);grid on
ticktick = [-10,-7,0,7,10];
xticks(ticktick)
yticks(ticktick)
xlabel("X Axis")
ylabel("Y Axis")
title("Boundary of the Initial Position")

figure;
theta = linspace(0,2*pi);
quiver(0,0,10,10,0,'k','LineWidth',1.5)
hold on
xxx = 20*cos(theta);
yyy = 20*sin(theta);
plot(10+xxx,10+yyy,'--k','LineWidth',1.2)
axis equal
xlim([-15,35])
ylim([-15,35])
xticks(-10:10:30)
yticks(-10:10:30)
plot(xx,yy,':k','LineWidth',0.1)
plot(yy,xx,':k','LineWidth',0.1)
grid on
title("Boundary of the Initial Velocity")
xlabel("X Axis")
ylabel("Y Axis")
end