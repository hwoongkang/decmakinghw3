classdef Cell < handle
	properties
		reward
		utility
		utilityPre = 0;
		utilities
		nextUtility
		isObstacle = false;
		pFault = 0;
		gamma = 0.95;
		left
		right
		up
		down
	end
	methods
		function obj = Cell(reward, boolObstacle)
			obj.reward =reward;
			obj.isObstacle = boolObstacle;
		end
		function setNeighbors(self,left,right,up,down)
			self.left = left;
			self.right = right;
			self.up = up;
			self.down = down;
		end
		function rewardList = get.utilities(self)
			% 			if self.up == self
			% 				rewardUp = 0;
			% 			else
			% 				rewardUp = self.up.rewardPre;
			% 			end
			% 			if self.down == self
			% 				rewardDown = 0;
			% 			else
			% 				rewardDown = self.down.rewardPre;
			% 			end
			% 			if self.left == self
			% 				rewardLeft = 0;
			% 			else
			% 				rewardLeft = self.left.rewardPre;
			% 			end
			% 			if self.right == self
			% 				rewardRight = 0 ;
			% 			else
			% 				rewardRight = self.right.rewardPre;
			% 			end
			% 			rewardList = [rewardUp;
			% 				rewardRight;
			% 				rewardDown;
			% 				rewardLeft];
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
					if self.up == self
% 						rewardOut = 0;
% 						return
					end
					dirNum = 1;
				case "right"
					if self.right == self
% 						rewardOut = 0;
% 						return
					end
					dirNum = 2;
				case "down"
					if self.down == self
% 						rewardOut = 0;
% 						return
					end
					dirNum = 3;
				case "left"
					if self.left == self
% 						rewardOut = 0;
% 						return
					end
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
	end
end