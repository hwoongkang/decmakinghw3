disp("2. Multiple agent collision avoidance")

%% agents in the circle with radius 30, with zero velocity
x0s = -15+30*rand(2,10);
v0s = zeros(2,10);

figure;
fig1 = gcf;

mySys = System2(x0s,v0s);
mySys.plot(fig1);