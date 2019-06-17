disp("1. 8 drones circle forming")
temp = 10:10:40;
start = [temp,-temp;
	zeros(1,8)];
goal = [20,-20,0,0,14,14,-14,-14;
	0,	0,	20,-20,14,-14,14,-14];
fig1=drawProb1();
fig2=drawProb1();
%% mean distance sum
goalPerm = perms(1:8);
minDist = 100000;
minTime = 100000;
for ind = 1:size(goalPerm,1)
	goalTemp = goal(:,goalPerm(ind,:));
	[distTemp,timeTemp,xTemp,yTemp] = feasibleTrajectory(start,goalTemp);
% 	diff = start - goalTemp;
% 	dist = sum(vecnorm(diff,2));
	if sum(distTemp)<minDist
		minSumPerm = goalPerm(ind,:);
		minDist = sum(distTemp);
		minDistTime= max(timeTemp);
		x11=xTemp;
		y11=yTemp;
	end
	if max(timeTemp)<minTime
		minTimePerm = goalPerm(ind,:);
		x12 = xTemp;
		y12 = yTemp;
		time = timeTemp;
		minTime = max(timeTemp);
		minTimeDist = sum(distTemp);
	end
end
dir1 = goal(:,minSumPerm) - start;
figure(fig1);
quiver(start(1,:),start(2,:),dir1(1,:),dir1(2,:),0,'k','LineWidth',1,'MaxHeadSize',0.2)
for i=1:8
	plot(x11(i,:),y11(i,:),'--r')
end
title("Minimizing the Total Distance")
dir2 = goal(:,minTimePerm) - start;
figure(fig2);
quiver(start(1,:),start(2,:),dir2(1,:),dir2(2,:),0,'k','LineWidth',1,'MaxHeadSize',0.2)
for i=1:8
	plot(x12(i,:),y12(i,:),'--r')
end
title("Minimizing the Moving Time")

%% mean time
% goalPerm = perms(1:8);
% maxDist = 100000;
% 
% for ind = 1:size(goalPerm,1)
% 	goalTemp = goal(:,goalPerm(ind,:));
% 	diff = start -goalTemp;
% 	dist = vecnorm(diff,2);
% 	maxTemp = max(dist);
% 	if maxTemp<maxDist
% 		maxDist = maxTemp;
% 		sum_ = sum(dist);
% 		minTimePerm = goalPerm(ind,:);
% 	end
% end
% dir = goal(:,minTimePerm) - start;
% figure(fig2);
% quiver(start(1,:),start(2,:),dir(1,:),dir(2,:),0,'k','LineWidth',1,'MaxHeadSize',0.1);
% foo = feasibleTrajectory(start,goal(:,minTimePerm));
% for i=1:8
% 	bar = foo{2,i};
% 	plot(bar.x,bar.y,'--r');
% end
% title("Minimizing the Moving Time")