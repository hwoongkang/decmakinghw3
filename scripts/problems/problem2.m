disp("2. Multiple agent collision avoidance")

%% agents in the circle with radius 30, with zero velocity

figure;
fig1 = gcf;

mySys = System2(15,20,20);
mySys.plot();
figure;
mySys.simulate(30)