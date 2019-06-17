classdef GridWorld < handle
	properties
		cells
	end
	methods
		function obj = GridWorld(sz1,sz2,pFault)
			cells = cell(sz1,sz2);
			for i=1:sz1
				for j=1:sz2
					cells{i,j} = Cell(-0.04,pFault);
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
			self.cells{i,j}.isGoal = true;
		end
		function error = update(self)
			[row,col] = size(self.cells);
			error = zeros(row,col);
			for i = 1:row
				for j=1:col
					self.cells{i,j}.update();
					error(i,j) = self.cells{i,j}.utility - self.cells{i,j}.utilityPre;
				end
			end
			for i=1:row
				for j= 1:col
					self.cells{i,j}.setPre();
				end
			end
		end
		function out = valueIteration(self)
			mapHistory = cell(1,500);
			it = 0;
			while(max(max(abs(self.update())))>1E-7)
				it= it+1;
				mapHistory{it} = self;
			end
			disp(it)
			self.draw(1)
			out = mapHistory(1,1:it);
		end
		function draw(self,mode)
			figure;
			ax=gca;
			[row, col] = size(self.cells);
			for i=1:row
				for j=1:col
					if self.cells{i,j}.isObstacle
						clr = [0.3,0.3,0.3];
					else
						clr = [1,1,1];
					end
					rectangle('Position',[j-1,i-1,1,1], 'FaceColor',clr);
					if ~self.cells{i,j}.isObstacle
						if mode == 0
							text(j-0.7,i-0.5,sprintf("%.2f",self.cells{i,j}.utilityPre));
						else
							if ~self.cells{i,j}.isGoal
								switch self.cells{i,j}.checkNeighbors()
									case "up"
										xTemp = j-0.5;
										yTemp = i-0.25;
										dirX = 0;
										dirY = -0.5;
									case "down"
										xTemp = j-0.5;
										yTemp = i-0.75;
										dirX = 0;
										dirY = 0.5;
									case "right"
										xTemp = j-0.75;
										yTemp = i-0.5;
										dirX = 0.5;
										dirY = 0;
									case "left"
										xTemp = j-0.25;
										yTemp = i-0.5;
										dirX = -0.5;
										dirY = 0;
								end
								quiver(xTemp,yTemp,dirX,dirY,0,'k','LineWidth',1,'MaxHeadSize',1)
								
								hold on
							else
								text(j-0.78,i-0.5,"GOAL")
							end
						end
					end
				end
			end
			axis equal
			axis ij
			ax.XAxisLocation = 'top';
			xlim([0,col]);ylim([0,row]);
			% 			view([90,90])
		end
	end
end