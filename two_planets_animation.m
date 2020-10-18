clear

%% 1. Constant + Variables definition
dt = 1/30; % for the video recording

G = 1;
m1 = 1;
m2 = 20;

t0 = 0;
tf = 30;
t_span = [t0 tf];

x10 = 10;
y10 = 0;
x20 = 0;
y20 = 0;
vx10 = 0;
vy10 = -10;
vx20 = 0;
vy20 = 0;

z0 = [x10 ; y10; x20 ; y20; vx10 ; vy10; vx20 ; vy20;];

%% 2. Solve ODE System 
opts = odeset('MaxStep',0.01);
[t, z] = ode45(@(t,z) ode_sys(z,G,m1,m2),t_span,z0,opts);

%% 3. Plots

% Curves to draw;
zk = zeros([(tf-t0)/dt,8]);

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
   curves = plot(zk(1:k,1), zk(1:k,2),'b--',zk(1:k,3), zk(1:k,4),'r--');
   planets = plot(zk(k,1), zk(k,2),'bo',zk(k,3), zk(k,4),'ro');
   planets(1).MarkerSize = 2;
   planets(2).MarkerSize = 15;
   
   xlim([min(z(:,1)) max(z(:,1))])
   ylim([min(z(:,2)) max(z(:,2))])
   hold off
   drawnow
   F(k) = getframe;
end

%% Videowritter
v = VideoWriter('2planets.avi');
v.FrameRate = 1/dt;
open(v);
writeVideo(v,F);
close(v);


%% FUNCTIONS

function dzdt = ode_sys(z,G,m1,m2)
    dzdt(1:4) = [z(5),z(6),z(7),z(8)];
    dzdt(5:6) = gravity_acceleration(G,m2,z(1:2),z(3:4));
    dzdt(7:8) = gravity_acceleration(G,m1,z(3:4),z(1:2));
    dzdt = dzdt';
end 

function a = gravity_acceleration(G,M,r,rM)
    a = G*M*norm(rM-r)^(-3/2)*(rM-r);
end