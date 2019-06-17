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
distSum = 100000;
for ind = 1:size(goalPerm,1)
	goalTemp = goal(:,goalPerm(ind,:));
	diff = start - goalTemp;
	dist = sum(vecnorm(diff,2));
	if dist<distSum
		minSumPerm = goalPerm(ind,:);
		distSum = dist;
	end
end
dir = goal(:,minSumPerm) - start;
figure(fig1);
quiver(start(1,:),start(2,:),dir(1,:),dir(2,:),0,'k','LineWidth',1,'MaxHeadSize',0.2)
title("Minimizing the Total Distance")
%% mean time
goalPerm = perms(1:8);
maxDist = 100000;

for ind = 1:size(goalPerm,1)
	goalTemp = goal(:,goalPerm(ind,:));
	diff = start -goalTemp;
	dist = vecnorm(diff,2);
	maxTemp = max(dist);
	if maxTemp<maxDist
		maxDist = maxTemp;
		minTimePerm = goalPerm(ind,:);
	end
end
dir = goal(:,minTimePerm) - start;
figure(fig2);
quiver(start(1,:),start(2,:),dir(1,:),dir(2,:),0,'k','LineWidth',1,'MaxHeadSize',0.1);
title("Minimizing the Moving Time")