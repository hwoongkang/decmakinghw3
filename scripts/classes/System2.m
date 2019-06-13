classdef System2 < handle
	properties
		N
		agents
		dt = 5E-2;
		XLim;YLim;
		K= - 0.1;
		trajectory
	end
	properties (Dependent)
		centerOfMass
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
		function obj = System2(boxSize, vel, N)
			
			obj.N = N;
			
			obj.agents = cell(1,N);
			
			x0s = -boxSize + 2 * boxSize * rand(2,N);
			
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
			
		end
		%% plotter wrapping the agent plotters
		function plot(self)
			for i = 1:length(self.agents)
				agent = self.agents{i}.plot();
				axis equal;xlim(self.XLim);ylim(self.YLim)
				hold on
			end
			com = self.centerOfMass;
			comHandle = plot(com(1),com(2),'sr','MarkerSize',8,'MarkerFaceColor','r');
			
			legend([agent, comHandle], {"agents", "center of mass"});
			hold off
		end
		%% system update
		function update(self)
			N = self.N;
			u = zeros(2,N);
			for agentNum = 1:N
				vTemp = self.agents{agentNum}.v;
				for agentNum2 = 1:N
					u(:,agentNum) = u(:,agentNum) + self.K * (vTemp - self.agents{agentNum2}.v);
				end
			end
			for agentNum = 1:N
				self.agents{agentNum}.update(u(:,agentNum),self.dt);
			end
% 			self.plot();
		end
		function simulate(self,tf)
			time = 0:self.dt:tf;
			xTemp = zeros(2,self.N,length(time));
			vTemp = zeros(2,self.N,length(time));
			xTemp(:,:,1) = self.x;
			vTemp(:,:,1) = self.v;
% 			self.plot();
% 			drawnow
			for t = 2:length(time)
				self.update();
				xTemp(:,:,t) = self.x;
				vTemp(:,:,t) = self.v;
% 				drawnow
			end
			self.trajectory.x = xTemp;
			self.trajectory.v = vTemp;
		end
	end
end
