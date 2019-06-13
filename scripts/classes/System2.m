classdef System2 < handle
	properties
		N
		agents
		dt = 5E-3;
		XLim;YLim;
	end
	properties (Dependent)
		centerOfMass
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
		function obj = System2(rad, N)
			
			obj.N = N;
			
			obj.agents = cell(1,N);
			
			x0s = -rad + 2 * rad * rand(2,N);
			v0s = zeros(2,N);
			
			for i = 1:obj.N
				obj.agents{i} = Agent(x0s(:,i), v0s(:,i));
			end
			
			obj.XLim = [-rad, rad];
			obj.YLim = [-rad, rad];
			
		end
		function plot(self,fig)
			figure(fig)
			for i = 1:length(self.agents)
				agent = self.agents{i}.plot(fig);
				hold on
			end
			com = self.centerOfMass;
			comHandle = plot(com(1),com(2),'sr','MarkerSize',8,'MarkerFaceColor','r');
			axis equal;xlim(self.XLim);ylim(self.YLim)
			legend([agent, comHandle], {"agents", "center of mass"});
			hold off
		end
	end
end

function initCheck(x0s,v0s)
	if size(x0s,1)~=2 || size(v0s,1)~=2
		error("initial conditions must be 2-D vectors")
	elseif size(x0s,2) ~= size(v0s,2)
		error("number of the initial conditions do not match")
	end
end