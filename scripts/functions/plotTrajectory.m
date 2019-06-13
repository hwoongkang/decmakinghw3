function plotTrajectory(traj,boxSize)
N = size(traj,2);
T = size(traj,3);

figure;
for t=1:T
	hold off
	for n = 1:N
		plot(traj(1,n,t),traj(2,n,t),'ks','MarkerSize',5,'MarkerFaceColor','k');
		hold on
	end
	axis equal
	xlim([-boxSize,boxSize])
	ylim([-boxSize,boxSize])
	drawnow
	
end
end