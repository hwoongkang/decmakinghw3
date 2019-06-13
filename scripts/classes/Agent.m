%% Single agent for the problem 2.
%{
Properties are the position and velocity
x: position, 2 by 1 vector
v: velocity, 2 by 1 vector

Methods: still no idea at all
plot
%}



classdef Agent < handle
	properties
		% position
		x
		% velocity
		v
		% boxSize
		boxSize
	end
	methods
		%% constructor
		function obj = Agent(x0,v0,boxSize)
			inputCheck(x0);
			inputCheck(v0);
			obj.x = x0;
			obj.v = v0;
			obj.boxSize = boxSize;
		end
		%% plotter
		function plotHandle = plot(self)
			plotHandle = plot(self.x(1),self.x(2),'ok','MarkerSize',5,'MarkerFaceColor','k');
		end
		%% dynamics
		function update(self,u,dt)
			inputCheck(u);
			
			vNext = self.v + u*dt;
			vTemp = (self.v + vNext) / 2;
			
			self.x = self.x + vTemp * dt;
			self.v = vNext;
			
			self.v = boxCheck(self);
		end
	end
end

function inputCheck(vect)
	if ~isvector(vect)
		error("not a vector")
	elseif ~iscolumn(vect)
		error("must be a column vector")
	elseif length(vect)~=2
		error("we should be in 2-D")
	end
end

function v = boxCheck(obj)
	pos = obj.x;
	vel = obj.v;
	L = obj.boxSize;
	x = pos(1); y = pos(2);
	vx = vel(1); vy = vel(2);
	
	if x<-L || x>L
% 		vx = -vx;
	end
	if y<-L || y>L
% 		vy = -vy;
	end
	v = [vx;vy];
end