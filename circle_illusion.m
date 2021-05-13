%% Circle Illusion - Moving dots to rotating circle
% Animation of a rotating circle that emerges from a set of dots moving
% harmonically in straight lines with different orientations.
%
%%

clear ; close all ; clc

%% Parameters

tf  = 30;                       % Final time                [s]
dt  = 30;                       % Frame rate                [fps]
t   = linspace(0,tf,tf*dt);     % Time                      [s]
T   = 10;                       % Oscillation period        [s]
f   = 1/T;                      % Oscillation frequency     [Hz]
A   = 1;                        % Amplitude                 [m]
N   = 8;                        % Number of dots
ph  = pi/N;                     % Phase                     [rad]
th  = pi/N;                     % Orientation               [rad]

%% Defining motion

% Preallocating
px = zeros(length(t),N);
py = zeros(length(t),N);

% Position matrices
for i = 1:N
    px(:,i) = A*sin(2*pi*f*t + i*ph) * cos(i*th);
    py(:,i) = A*sin(2*pi*f*t + i*ph) * sin(i*th);
end

%% Animation

figure
hold on ; grid on ; box on ; axis equal
set(gca,'xlim',[-1.1 1.1],'ylim',[-1.1 1.1])
set(gca,'XTick',[],'YTick',[])

% Create and open video writer object
v = VideoWriter('circle_illusion.avi');
v.Quality = 100;
open(v);

% Generating frames
for i=1:length(t)
    cla
    for j=1:N
        plot([-A*cos(j*th) A*cos(j*th)],[-A*sin(j*th) A*sin(j*th)],':','Color',[100 100 100]/255)
    end
    plot(px(i,:),py(i,:),'ro','MarkerFaceColor','r')
    frame = getframe(gcf);
    writeVideo(v,frame);
end

close(v);
