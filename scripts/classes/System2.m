classdef System2 < handle
	properties
		N
		boxSize
		agents
		dt
		XLim;YLim;
		K
		x0s
		v0s
	end
	properties (Dependent)
		centerOfMass
		meanV
		x
		v
	end
	methods
		%% constructor with circle radius, number of agents
		%{
		N: number of agents
		boxSize: size of the region wherein agents will be generatetd
		meanV: mean of the initial velocity distribution
		vel: region the initial velocity can differ from the meanV
		K: control input
		dt: sampling Hz
		%}
		function obj = System2(N, boxSize, meanV, vel,K,dt)
			obj.dt = dt;
			obj.N = N;
			obj.K = K;
			obj.agents = cell(1,N);
			
			x0s = -boxSize/4 + 0.5* boxSize * rand(2,N);
			
			v0s = zeros(2,N);
			for i = 1:N
				vx = -vel + 2 * vel*rand();
				y = sqrt(vel^2 - vx^2);
				vy = -y+2*y*rand();
				v0s(:,i) = [vx;vy];
			end
			v0s = meanV + v0s;
			for i = 1:obj.N
				obj.agents{i} = Agent(x0s(:,i), v0s(:,i),boxSize);
			end
			obj.x0s = x0s;
			obj.v0s = v0s;
			obj.XLim = [-boxSize, boxSize];
			obj.YLim = [-boxSize, boxSize];
			obj.boxSize = boxSize;
		end
		%% getters
		%{
		centerOfMass: position of the center of mass
		meanV: mean velocity of the agents
		x: position of the agents( 2 by N )
		v: velocity of the agents( 2 by N )
		%}
		function cm = get.centerOfMass(obj)
			sum = [0;0];
			for i=1:obj.N
				sum = sum + obj.agents{i}.x;
			end
			cm = sum/obj.N;
		end
		function sum = get.meanV(obj)
			sum = [0;0];
			for i=1:obj.N
				sum =sum + obj.agents{i}.v;
			end
			sum = sum/obj.N;
		end
		function x = get.x(obj)
			x = zeros(2,obj.N);
			for i=1:obj.N
				x(:,i) = obj.agents{i}.x;
			end
		end
		function v = get.v(obj)
			v = zeros(2,obj.N);
			for i=1:obj.N
				v(:,i) = obj.agents{i}.v;
			end
		end
		%% reset!
		function reset(self)
			for i=1:self.N
				self.agents{i}.x = self.x0s(:,i);
				self.agents{i}.v = self.v0s(:,i);
			end
		end
		%% plotter wrapping the agent plotters
		% not using now (190614 1008)
		function plot(self)
			x = self.x;
			agent = plot(x(1,:),x(2,:),'ok','MarkerSize',5,'MarkerFaceColor','k');hold on;
			v = self.v;
			quiver(x(1,:),x(2,:),v(1,:), v(2,:),'--k','LineWidth',0.8)
			com = self.centerOfMass;
			comHandle = plot(com(1),com(2),'sr','MarkerSize',8,'MarkerFaceColor','r');
			vel = self.meanV;
			quiver(com(1),com(2),vel(1),vel(2),'r','LineWidth',2)
			
			axis equal;xlim(self.XLim);ylim(self.YLim)
			legend([agent, comHandle], {"agents", "center of mass"});
			hold off
		end
		%% system updates
		%% problem 2-(a)
		function update(self)
			N_ = self.N;
			u = zeros(2,N_);
			v_ = self.v;
			for agentNum = 1:N_
				u(:,agentNum) = self.K*mean(v_ - v_(:,agentNum),2);
				% 				vTemp = self.agents{agentNum}.v;
				%
				% 				for agentNum2 = 1:N
				% 					u(:,agentNum) = u(:,agentNum) + self.K * (self.agents{agentNum2}.v - vTemp);
				% 				end
			end
			for agentNum = 1:N_
				self.agents{agentNum}.update(u(:,agentNum),self.dt);
			end
			% 			self.plot();
		end
		%% problem 2-(b)
		function update2(self)
			N_ = self.N;
			u = zeros(2,N_);
			for agentNum = 1:N_
				% get current states
				vTemp = self.v;
				xTemp = self.x;
				
				% velocity profile for the input
				vNow = vTemp(:,agentNum);
				vTemp(:,agentNum) = [];
				vDiff = vTemp - vNow;
				
				% communication limit
				% agent position
				xNow = xTemp(:,agentNum);
				% others' position
				xTemp(:,agentNum) = [];
				% distance
				xDiff = xTemp - xNow;
				xNorm = vecnorm(xDiff);
				% closest 10
				[~, ind] = sort(xNorm);
				vDiff = vDiff(:,ind(1:10));
				
				u(:,agentNum) = self.K*mean(vDiff,2);
				
			end
			for agentNum = 1:N_
				self.agents{agentNum}.update(u(:,agentNum),self.dt);
			end
		end
		%% problem 2-(c)
		function update3(self,distLimit,flockGain)
			N_ = self.N;
			u = zeros(2,N_);
			for agentNum = 1:N_
				% current states
				xTemp = self.x;
				vTemp = self.v;
				
				% velocity profile
				vNow = vTemp(:,agentNum);
				vTemp(:,agentNum) = [];
				vDiff = vTemp - vNow;
				
				% communication limit
				xNow = xTemp(:,agentNum);
				xTemp(:,agentNum) = [];
				xDiff = xTemp - xNow;
				xNorm = vecnorm(xDiff);
				
				% sort it
				[sortedNorm,ind] = sort(xNorm);
				
				% communication gain
				vForControl = vDiff(:,ind(1:10));
				uComm = self.K*mean(vForControl,2);
				
				% flocking behavior
				it = 1;
				uFlock = zeros(2,1);
				while(sortedNorm(it)<distLimit)
					uFlock = uFlock - (flockGain/sortedNorm(it))*xDiff(:,ind(it));
					it = it+1;
				end
				
				u(:,agentNum) = uComm + uFlock;
			end
			for agentNum = 1:N_
				self.agents{agentNum}.update(u(:,agentNum),self.dt);
			end
		end
		function traj = simulate(self,tf,probNum,distLimit,flockGain)
			if nargin<4
				distLimit = 1;
				flockGain = 3;
			end
			time = 0:self.dt:tf;
			xTemp = zeros(2,self.N,length(time));
			vTemp = zeros(2,self.N,length(time));
			centerOfMass_ = zeros(2,length(time));
			meanV_ = zeros(2,length(time));
			
			xTemp(:,:,1) = self.x;
			vTemp(:,:,1) = self.v;
			centerOfMass_(:,1) = self.centerOfMass;
			meanV_(:,1) = self.meanV;
			% 			self.
			% 			drawnow
			for t = 2:length(time)
				switch probNum
					case 1
						self.update();
					case 2
						self.update2();
					case 3
						self.update3(distLimit,flockGain);
				end
				% 				text(self.boxSize-1,-self.boxSize+1,sprintf("t = %.3fs", time(t)))
				xTemp(:,:,t) = self.x;
				vTemp(:,:,t) = self.v;
				centerOfMass_(:,t) = self.centerOfMass;
				meanV_(:,t) = self.meanV;
				% 				drawnow
			end
			traj.time = time;
			traj.x = xTemp;
			traj.v= vTemp;
			traj.centerOfMass = centerOfMass_;
			traj.meanV = meanV_;
		end
	end
end
