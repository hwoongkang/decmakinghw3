classdef System2 < handle
	properties
		N
		boxSize
		agents
		dt
		XLim;YLim;
		K=  0.5;
		trajectory
	end
	properties (Dependent)
		centerOfMass
		meanV
		x
		v
	end
	methods
		%% cm getter
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
		%% constructor with circle radius, number of agents
		function obj = System2(N, boxSize, vel,dt)
			obj.dt = dt;
			obj.N = N;
			
			obj.agents = cell(1,N);
			
			x0s = -boxSize/4 + 0.5* boxSize * rand(2,N);
			
			v0s = zeros(2,N);
			for i = 1:N
				vx = -vel + 2 * vel*rand();
				y = sqrt(vel^2 - vx^2);
				vy = -y+2*y*rand();
				v0s(:,i) = [vx;vy];
			end
			
			for i = 1:obj.N
				obj.agents{i} = Agent(x0s(:,i), v0s(:,i),boxSize);
			end
			
			obj.XLim = [-boxSize, boxSize];
			obj.YLim = [-boxSize, boxSize];
			obj.boxSize = boxSize;
		end
		%% plotter wrapping the agent plotters
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
		%% system update
		function update(self)
			N = self.N;
			u = zeros(2,N);
			v = self.v;
			for agentNum = 1:N
				u(:,agentNum) = self.K*sum(v - v(:,agentNum),2);
				% 				vTemp = self.agents{agentNum}.v;
				%
				% 				for agentNum2 = 1:N
				% 					u(:,agentNum) = u(:,agentNum) + self.K * (self.agents{agentNum2}.v - vTemp);
				% 				end
			end
			for agentNum = 1:N
				self.agents{agentNum}.update(u(:,agentNum),self.dt);
			end
			% 			self.plot();
		end
		function update2(self)
			N = self.N;
			u = zeros(2,N);
			for agentNum = 1:N
				vTemp = self.v;
				xTemp = self.x;
				
				vNow = vTemp(:,agentNum);
				vTemp(:,agentNum) = [];
				
				xNow = xTemp(:,agentNum);
				xTemp(:,agentNum) = [];
				
				vDiff = vTemp - vNow;
				
				xNorm = vecnorm(xTemp);
				[~, ind] = sort(xNorm);
				vDiff = vDiff(:,ind(1:10));
				u(:,agentNum) = self.K*sum(vDiff,2);
				
			end
			for agentNum = 1:N
				self.agents{agentNum}.update(u(:,agentNum),self.dt);
			end
		end
		function simulate(self,tf)
			time = 0:self.dt:tf;
			xTemp = zeros(2,self.N,length(time));
			vTemp = zeros(2,self.N,length(time));
			com = zeros(2,length(time));
			meanV = zeros(2,length(time));
			
			xTemp(:,:,1) = self.x;
			vTemp(:,:,1) = self.v;
			com(:,1) = self.centerOfMass;
			meanV(:,1) = self.meanV;
			% 			self.
			% 			drawnow
			for t = 2:length(time)
				self.update2();
				% 				text(self.boxSize-1,-self.boxSize+1,sprintf("t = %.3fs", time(t)))
				xTemp(:,:,t) = self.x;
				vTemp(:,:,t) = self.v;
				com(:,t) = self.centerOfMass;
				meanV(:,t) = self.meanV;
				% 				drawnow
			end
			self.trajectory.x = xTemp;
			self.trajectory.v = vTemp;
			self.trajectory.com = com;
			self.trajectory.meanV = meanV;
		end
	end
end
