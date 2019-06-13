classdef System2 < handle
	properties
		agents
		dt = 5E-3;
	end
	methods
		function obj = System2(x0s,v0s)
			initCheck(x0s,v0s);
			N = size(x0s,2);
			obj.agents = cell(1,N);
			for i = 1:N
				obj.agents{i} = Agent(x0s(:,i), v0s(:,i));
			end
		end
		function plot(self,fig)
			figure(fig)
			for i = 1:length(self.agents)
				self.agents{i}.plot(fig);
			end
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