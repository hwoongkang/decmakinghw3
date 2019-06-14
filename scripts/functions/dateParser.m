function filename = dateParser()
ms = ["Jan", "Feb", "Mar", "Apr" ,"May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
time = clock;
h = time(4);
if h<10
	h = "0" + string(h);
else
	h = string(h);
end
mi = string(time(5));
s = string(floor(time(6)));
d = string(time(3));
mo = ms(time(2)).upper();
y = string(time(1)-2000);
filename = y+mo+d+"_"+h +mi + s;
end