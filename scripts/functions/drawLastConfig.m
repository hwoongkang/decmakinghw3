function drawLastConfig(traj)
	x = traj.x(:,:,end);
	v = traj.v(:,:,end);
	com = traj.centerOfMass(:,end);
	meanV = traj.meanV(:,end);
	figure;
	agent = plot(x(1,:),x(2,:),'ok','MarkerSize',5,'MarkerFaceColor','k');
	hold on
	quiver(x(1,:),x(2,:),v(1,:)/5,v(2,:)/5,0,'--k')
	cm = plot(com(1),com(2),'sr','MarkerSize',8,'MarkerFaceColor','r');
	quiver(com(1),com(2),meanV(1)/5,meanV(2)/5,0,'r','LineWidth',2)
	
	xMax = max(x(1,:));
	xMin = min(x(1,:));
	
	yMax = max(x(2,:));
	yMin = min(x(2,:));
	
	rad = 0.65*max(yMax-yMin, xMax-xMin);
	
	axis equal
	xlim(com(1) + [-rad, rad]);
	ylim(com(2) + [-rad, rad]);
	
	
	legend([agent,cm],["Agents", "Center of Mass"])
	xlabel("X Axis")
	ylabel("Y Axis")
	grid on;
end