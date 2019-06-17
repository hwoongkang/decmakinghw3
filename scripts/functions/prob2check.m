function prob2check(traj)
figure;
% 2 30 T
for n = 1:30
	for vx = 1:2
		subplot(2,1,vx)
		plot(traj.time, squeeze(traj.v(vx,n,:)).'-traj.meanV(vx,:),':k');hold on;
	end
end
sgtitle("Error from the mean velocity")
subplot(2,1,1)
title("X Axis")
ylabel("Velocity [m/s^2]")
subplot(2,1,2)
title("Y Axis")
ylabel("Velocity [m/s^2]")
xlabel("Time [s]")

figure;
% for n=1:30
	for vx=1:2
		subplot(2,1,vx)
		plot(traj.time, squeeze(mean(traj.v(vx,:,:).^2,2)).' - traj.meanV(vx,:).^2,'k');hold on;
	end
% end
sgtitle("Variance of the velocity")
subplot(2,1,1)
title("X Axis")
ylabel("Velocity [m/s^2]")
subplot(2,1,2)
title("Y Axis")
ylabel("Velocity [m/s^2]")
xlabel("Time [s]")

end