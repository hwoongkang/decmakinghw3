disp("3. Reinforcement Learning")
obstacles = [2,2;
	3,2;
	4,4;
	1,6;
	2,6]
myMaP= GridWorld(4,7);
myMaP.setObstacles(obstacles)
myMaP.setGoal([1,7])
myMaP.draw()
myMaP.valueIteration()