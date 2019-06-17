classdef GridWorld < handle
	properties
		cells
	end
	methods
		function obj = GridWorld(sz1,sz2)
			cells = cell(sz1,sz2);
			for i=1:sz1
				for j=1:sz2
					cells{i,j} = Cell(-0.04,false);
				end
			end
			%% top row
			for i = 1:sz1
				for j=1:sz2
					if i==sz1
						iDown = sz1;
					else
						iDown= i+1;
					end
					if i==1
						iUp =1;
					else
						iUp = i-1;
					end
					if j==sz2
						jRight = sz2;
					else
						jRight = j+1;
					end
					if j==1
						jLeft = 1;
					else
						jLeft = j-1;
					end
					cells{i,j}.setNeighbors(cells{i,jLeft},cells{i,jRight},cells{iUp,j},cells{iDown,j});
				end
			end
			obj.cells = cells;
		end
		function setObstacles(self,listPos)
			numObstacles = size(listPos,1);
			for ind = 1:numObstacles
				i = listPos(ind,1);
				j = listPos(ind,2);
				c = self.cells{i,j};
				c.isObstacle = true;
				c.reward = 0;
				c.left.right = c.left;
				c.right.left = c.right;
				c.up.down = c.up;
				c.down.up = c.down;
				c.left = c;
				c.right = c;
				c.up = c;
				c.down = c;
			end
		end
		function setGoal(self,posGoal)
			i=posGoal(1);
			j = posGoal(2);
			self.cells{i,j}.reward = 1;
		end
		function update(self)
			[row,col] = size(self.cells);
			for i = 1:row
				for j=1:col
					self.cells{i,j}.update();
				end
			end
			for i=1:row
				for j= 1:col
					self.cells{i,j}.setPre();
				end
			end
		end
		
		function draw(self)
			figure;
			[row, col] = size(self.cells);
			for i=1:row
				for j=1:col
					if self.cells{i,j}.isObstacle
						clr = [0.3,0.3,0.3];
					else
						clr = [1,1,1];
					end
					rectangle('Position',[i-1,j-1,1,1], 'FaceColor',clr);
					text(i-0.7,j-0.5,string(self.cells{i,j}.utilityPre));
					hold on
				end
			end
			axis equal
			xlim([0,row]);ylim([0,col]);
		end
	end
end