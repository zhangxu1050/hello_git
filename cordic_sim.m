%%%%%%%%%%%%  CORDIC sim %%%%%%%%%%%%%%%%
% data :2022-9-21
% au : zx
% description:theroy sim
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&%%%%%%%%%

clear all
close all
N = 10 ; %Ðý×ª´ÎÊý
%%
degree = pi/3 ;
degree2= pi/18;
xp = cos(degree);
yp = sin(degree);
xq = cos(degree2)*(xp - yp*tan(degree2));
yq = cos(degree2)*(yp + xp*tan(degree2));
xr = xp - yp*tan(degree2) ;
yr = yp + xp*tan(degree2) ;
d = -1 ;
d = 1 ;
degree(i) = arctan(d(i)*(1/2^i));
%% 
for i = 1 : N
    x(i+1) = x(i) - y(i)*tan(degree(i));
    y(i+1) = y(i) + x(i)*tan(degree(i));
end
x = x(N+1);
y = y(N+1);


for i = 1 : N
    x(i+1) = x(i) - y(i)*d(i)*(1/2^i);
    y(i+1) = y(i) + x(i)*d(i)*(1/2^i);
end
x = x(N+1);
y = y(N+1);

for i = 1 : N
    z(i+1) = z(i) - d(i)*anctan(1/2^i))
end








