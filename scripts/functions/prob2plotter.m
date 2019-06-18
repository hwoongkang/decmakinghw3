function prob2plotter(prob2ans)

prob2check(prob2ans.trajA)
prob2check(prob2ans.trajB)
prob2check(prob2ans.trajC)

drawLastConfig(prob2ans.trajA)
title("Configuration at t_f=7, 2(a)")
drawLastConfig(prob2ans.trajB)
title("Configuration at t_f=7, 2(b)")
drawLastConfig(prob2ans.trajC)
title("Configuration at t_f=7, 2(c)")
end