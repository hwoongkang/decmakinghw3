function plotTrajectory(traj,dt,tf,filename)
x = traj.x;
v = traj.v;
com = traj.centerOfMass;
meanV = traj.meanV;
N = size(x,2);
T = size(x,3);
vid = VideoWriter("..\figures\"+filename+".mp4",'MPEG-4');
open(vid);
figure;
fig = gcf;
meanTemp = normc(meanV);

xMax = max(traj.x(1,:,end));
yMax = max(traj.x(2,:,end));
xMin = min(traj.x(1,:,end));
yMin = min(traj.x(2,:,end));

boxSize = 0.55*max(yMax-yMin,xMax-xMin);

for t=1:tf/dt
	hold off
	% 	for n = 1:N
	% 		plot(x(1,n,t),x(2,n,t),'ks','MarkerSize',5,'MarkerFaceColor','k');
	% 		quiver(x(1,n,t),x(2,n,t) , v(1,n,t), v(2,n,t),'--k','LineWidth',1.2,'MaxHeadSize',0.8);
	% 		hold on
	% 	end
	vTemp = normc(v(:,:,t));
	plot(x(1,:,t),x(2,:,t),'ks','MarkerSize',7,'MarkerFaceColor','k');
	hold on
	quiver(x(1,:,t),x(2,:,t), v(1,:,t)/5, v(2,:,t)/5,0,'k','LineWidth',0.8,'MaxHeadSize',0.5);
	
	plot(com(1,t),com(2,t),'ro','MarkerSize',8','MarkerFaceColor','r');
	quiver(com(1,t),com(2,t),meanV(1,t)/5,meanV(2,t)/5,0,'r','LineWidth',2,'MaxHeadSize',1.2);
	axis equal
% 	xlim([-boxSize, boxSize]);
% 	ylim([-boxSize,boxSize]);
	grid on
	legend(sprintf("t=%.3fs",(t-1)*dt))
	xlim(com(1,t)+[-boxSize,boxSize])
	ylim(com(2,t)+[-boxSize,boxSize])
% 	drawnow
	frame = getframe(fig);
	for slowmo = 1:1
		writeVideo(vid,frame);
	end
end
close(vid);
end