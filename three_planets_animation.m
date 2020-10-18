clear

%% 1. Constant + Variables definition
dt = 1/30; % for the video recording

G = 0.5;
m1 = 100;
m2 = 20;
m3 = 1;

t0 = 0;
tf = 30;
t_span = [t0 tf];

x10 = 0;
y10 = 0;
x20 = 100;
y20 = 0;
x30 = 101;
y30 = 0;
vx10 = 0;
vy10 = 0;
vx20 = 0;
vy20 = 20;
vx30 = 0;
vy30 = 25;

z0 = [x10 ; y10; x20 ; y20; x30 ; y30; vx10 ; vy10; vx20 ; vy20; vx30 ; vy30];

%% 2. Solve ODE System 
opts = odeset('MaxStep',0.01);
[t, z] = ode45(@(t,z) ode_sys(z,G,m1,m2,m3),t_span,z0,opts);

%% 3. Plots

% Curves to draw;
zk = zeros([(tf-t0)/dt,12]);

f = figure;
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])

for tk = t0:dt:(tf-1)
   clf; 
   k = int32(tk/dt+1);
   i = find(t >= tk,1);
   zk(k,:) = z(i,:);
   
   hold on
   curves = plot(zk(1:k,1), zk(1:k,2),'b--',zk(1:k,3), zk(1:k,4),'r--',zk(1:k,5), zk(1:k,6),'k--');
   planets = plot(zk(k,1), zk(k,2),'bo',zk(k,3), zk(k,4),'ro',zk(k,5), zk(k,6),'ko');
   planets(1).MarkerSize = 15;
   planets(2).MarkerSize = 4;
   planets(3).MarkerSize = 2;
   
   xlim([min(z(:,5)) max(z(:,5))])
   ylim([min(z(:,6)) max(z(:,6))])
   hold off
   drawnow
   F(k) = getframe;
end

%% Videowritter
v = VideoWriter('3planets.avi');
v.FrameRate = 1/dt;
open(v);
writeVideo(v,F);
close(v);


%% FUNCTIONS

function dzdt = ode_sys(z,G,m1,m2,m3)
    dzdt(1:6) = [z(7),z(8),z(9),z(10),z(11),z(12)];
    dzdt(7:8) = gravity_acceleration(G,m2,z(1:2),z(3:4)) + gravity_acceleration(G,m3,z(1:2),z(5:6));
    dzdt(9:10) = gravity_acceleration(G,m1,z(3:4),z(1:2)) + gravity_acceleration(G,m3,z(3:4),z(5:6));
    dzdt(11:12) = gravity_acceleration(G,m1,z(5:6),z(1:2)) + gravity_acceleration(G,m2,z(5:6),z(3:4));
    dzdt = dzdt';
end 

function a = gravity_acceleration(G,M,r,rM)
    a = G*M*norm(rM-r)^(-3/2)*(rM-r);
end