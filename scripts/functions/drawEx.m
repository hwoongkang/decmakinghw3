function drawEx()
figure;
temp = -2:1:2;
one = ones(size(temp));
x = [2*one,-temp,-2*one,temp];
y = [temp,2*one,-temp,-2*one];
plot(x,y,'ok')
hold on
f1=quiver(0*x,0*y,x,y,0,'k','LineWidth',0.5,'MaxHeadSize',0.15);
axis equal
xlim([-2.2,2.2])
ylim([-2.2,2.2])

grid on
xticks(-2:2);
yticks(-2:2);
f2=quiver(0,0,cos(pi/5),sin(pi/5),0,'k','LineWidth',2,'MaxHeadSize',0.7);

legend([f1,f2],{"Possible Velocity","Required Direction"})
title("Velocity Constraint of the Drones")
end