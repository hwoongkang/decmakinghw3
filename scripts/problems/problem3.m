function output = problem3(pFault)
disp("3. Reinforcement Learning")
obstacles = [2,2;
	3,2;
	4,4;
	1,6;
	2,6];
myMap= GridWorld(4,7,pFault);
myMap.setObstacles(obstacles)
myMap.setGoal([1,7])
output = myMap.valueIteration();
end