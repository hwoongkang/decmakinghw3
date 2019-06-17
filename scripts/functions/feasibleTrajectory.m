function [distOut,timeOut,xOut,yOut] = feasibleTrajectory(start,goal)
diffs = goal - start;
N = size(diffs,2);

slopes = [-1E-6,-2;
	-1,-2;
	-2,-2;
	-2,-1;
	-2,0;
	-2,1;
	-2,2;
	-1,2;
	0,2;
	1,2;
	2,2;
	2,1;
	2,0;
	2,-1;
	2,-2;
	1,-2;
	0,-2];
speed = vecnorm(slopes,2,2);
speed(1) = 2;
thetas = zeros(size(slopes,1),1);
for i=1:size(slopes,1)
	thetas(i) =atan2(slopes(i,1),slopes(i,2));
end

% output = cell(2,N);

distOut = zeros(1,N);
timeOut = zeros(1,N);
xOut = zeros(N,199);
yOut = zeros(N,199);
for i=1:N
	phi = atan2(diffs(2,i),diffs(1,i));
	ind=1;
	while(phi>thetas(ind))
		ind = ind+1;
	end
	if norm(phi-thetas(ind))<=1E-7
		distOut(i) = norm(goal(:,i) - start(:,i));
		timeOut(i) = distOut(i)/speed(ind);
% 		temp.x = 
% 		temp.y = linspace(start(2,i),goal(2,i),199);
		xOut(i,:) = linspace(start(1,i),goal(1,i),199);
		yOut(i,:) = linspace(start(2,i),goal(2,i),199);
		continue
	end
	slope1 = tan(thetas(ind));
	slope2 = tan(thetas(ind-1));
	x1 = start(1,i);
	x2= goal(1,i);
	y1 = start(2,i);
	y2 = goal(2,i);
	if abs(slope1)>1E6
% 		y1Temp = y1+50*sign(slope1);
		poly1x = [x1,x1];
		poly1y = [y1-50, y1+50];
	else
		y1Temp = slope1*(x2-x1)+y1;
		poly1x = [x1,x2];
		poly1y = [y1,y1Temp];
	end
	if abs(slope2)>1E6
% 		y2Temp = y2 + 50*sign(slope1);
		poly2x = [x2,x2];
		poly2y = [y2-50,y2+50];
	else
		y2Temp = slope2*(x1-x2)+y2;
		poly2x = [x2,x1];
		poly2y = [y2,y2Temp];
	end
% 	
% 	poly1x = [x1,x2];
% 	poly1y = [y1,y1Temp];
% 	poly2x = [x2,x1];
% 	poly2y = [y2,y2Temp];
	
	[xMid, yMid] = polyxpoly(poly1x,poly1y,poly2x,poly2y);
	
	diff1 = [x1;y1] - [xMid;yMid];
	diff2 = [x2;y2] - [xMid;yMid];
	
	dist1 = norm(diff1);
	dist2 = norm(diff2);
	
	time1 = dist1/speed(ind);
	time2 = dist2/speed(ind-1);
	
	distOut(1,i) = dist1+dist2;
	timeOut(1,i) = time1+time2;
	
% 	output{1,i} = norm([xMid-x1,yMid-y1]) + norm([x2-xMid, y2-yMid]);
	
	xx1 = linspace(x1,xMid);
	xx2 = linspace(xMid,x2);
	if abs(slope1)>1E6
		yy2 = slope2*(xx2-x2) + y2;
		yy1 = linspace(y1,yy2(1));
	elseif abs(slope2)>1E6
		yy1 = slope1*(xx1-x1) + y1;
		yy2 = linspace(yy1(end),y2);
	else
		yy1 = slope1*(xx1-x1) + y1;
		yy2 = slope2*(xx2-x2) + y2;
	end
% 	temp.x = [xx1,xx2(2:end)];
% 	temp.y = [yy1,yy2(2:end)];
	xOut(i,:) = [xx1,xx2(2:end)];
	yOut(i,:) = [yy1,yy2(2:end)];
	
end
end