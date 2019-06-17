disp("1. 8 drones circle forming")
temp = 10:10:40;
start = [temp,-temp;
	zeros(1,8)];
goal = [20,-20,0,0,14,14,-14,-14;
	0,	0,	20,-20,14,-14,14,-14];
figure;
f1 = plot(start(1,:),start(2,:),'sk');hold on;
f2 = plot(goal(1,:),goal(2,:),'*k');
theta = linspace(0,2*pi,200);
x = 20*cos(theta); y= 20*sin(theta);
f3 = plot(x,y,':k');
axis equal
xlim([-45,45]);ylim([-45,45])
legend([f1,f2],{'start','goal'});