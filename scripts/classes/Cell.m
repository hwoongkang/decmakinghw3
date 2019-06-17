classdef Cell < handle
	properties
		reward
		utility = 0;
		utilityPre = 0;
		isObstacle = false;
		isGoal = false;
		pFault
		gamma = 0.9;
		
		left
		right
		up
		down
	end
	properties (Dependent)
		utilities
		nextUtility
	end
	methods
		function obj = Cell(reward, pFault)
			obj.reward =reward;
			obj.pFault = pFault;
		end
		function setNeighbors(self,left,right,up,down)
			self.left = left;
			self.right = right;
			self.up = up;
			self.down = down;
		end
		function rewardList = get.utilities(self)
			rewardList = [ self.up.utilityPre;
				self.right.utilityPre;
				self.down.utilityPre;
				self.left.utilityPre];
		end
		function nextRewards = get.nextUtility(self)
			nextRewards = [self.nextReward("up");
				self.nextReward("right");
				self.nextReward("down");
				self.nextReward("left")];
		end
		function rewardOut = nextReward(self,dir)
			pFault = self.pFault;
			p = 1-3*pFault;
			dp = p - pFault;
			dirNum = 0;
			switch dir
				case "up"
					dirNum = 1;
				case "right"
					dirNum = 2;
				case "down"
					dirNum = 3;
				case "left"
					dirNum = 4;
			end
			utilities = self.utilities;
			rewardOut = pFault*sum(utilities) + dp * utilities(dirNum);
		end
		function update(self)
			% 			self.reward = self.rewardPre + self.gamma*max(self.nextRewards);
			self.utility = self.reward + self.gamma*max(self.nextUtility);
		end
		function setPre(self)
			self.utilityPre = self.utility;
		end
		function dir = checkNeighbors(self)
			[~,ind] = max(self.utilities);
			switch ind
				case 1
					dir = "up";
				case 2
					dir = "right";
				case 3
					dir = "down";
				case 4
					dir = "left";
			end
		end
	end
end