function c = SmoothCurve(u,Res); 


x=rg(u(1,:)',Res);
y=rg(u(2,:)',Res);
[xi,yi] = Curvefitting(x,y,Res);

c=[xi',yi'];