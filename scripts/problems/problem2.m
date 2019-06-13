function mySys = problem2(N,boxSize,vel,dt,tf,filename)
disp("2. Multiple agent collision avoidance")

%% agents in the circle with radius 30, with zero velocity
mySys = System2(N,boxSize,vel,dt);
figure;
mySys.plot();
title("initial condition")
mySys.simulate(tf)

plotTrajectory(mySys.trajectory,vel*tf/5,filename)
end