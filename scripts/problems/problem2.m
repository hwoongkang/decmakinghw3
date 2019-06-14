function prob2ans = problem2(N,boxSize,meanV, vel,K,dt,tf,distLimit,flockGain,filename)
disp("2. Multiple agent collision avoidance")

%% agents in the circle with radius 30, with zero velocity
mySys = System2(N,boxSize,meanV,vel,K,dt);
figure;
mySys.plot();
title("initial condition")
trajA = mySys.simulate(tf,1);

mySys.reset();
trajB = mySys.simulate(tf,2);

mySys.reset();
trajC = mySys.simulate(tf,3,distLimit,flockGain);
prob2ans.sys = mySys;
prob2ans.trajA = trajA;
prob2ans.trajB = trajB;
prob2ans.trajC = trajC;
% plotTrajectory(trajA,vel*tf/5,filename)
end