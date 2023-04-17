clear figures
clear vars
clc

%Constants
Re = 6371; %Earth radius in km
RAAN = 180;
h = 5000; %spacecraft altitude
a = Re + h; %semi-major axis
e = 0.1;
i = 150;
w = 100;

nu = [0:1:360];
[N M] = size(nu);

for o = 1:M;
    r(o) = a.*(1-e.*e)./(1+e.*cosd(nu(o)));
    xp(o,1) = r(o)*cosd(nu(o));
    xp(o,2) = r(o)*sind(nu(o));
    xp(o,3) = 0;
end



% Calculate ground track
[lat, lon] = ECEF2geodetic(X3(:,1), X3(:,2), X3(:,3), Re, 0);

% Adjust longitude to take into account Earth's rotation
GMST = @(jd) mod(280.46061837 + 360.98564736629 * (jd - 2451545) + 0.000387933 * (jd - 2451545).^2, 360);
jd = linspace(juliandate(datetime('now')), juliandate(datetime('now'))+1, length(lat)); % simulate one day of ground track
GMST_angle = GMST(jd);
lon = lon + GMST_angle';

% Convert longitude to range [-180, 180]
lon = wrapTo180(lon);


% Define rotation matrices
Rz = @(theta) [cosd(theta) sind(theta) 0; -sind(theta) cosd(theta) 0; 0 0 1];
Rx = @(theta) [1 0 0; 0 cosd(theta) sind(theta); 0 -sind(theta) cosd(theta)];

X1 = Rz(w)*xp.';
X2 = Rx(i)*X1;
X3 = Rz(RAAN)*X2;

figure(1);
plot(xp(:,1),xp(:,2));
axis equal
title('Orbit Shape');
xlabel('X Direction');
ylabel('Y Direction');


figure(2);
plot3(X3(1,:),X3(2,:),X3(3,:),'.');
[x,y,z] = sphere(50); % Create a sphere
surf(x*Re, y*Re, z*Re , 'EdgeColor', 'none'); % Plot Earth
axis equal
s.FaceColor = 'texturemap';    % use texture mapping
s.CData = topo;                % set color data to topographic data
title('Orbit and Earth');
hold on;
grid on;

% Plot ground track on map
figure(3);
rgb = imread("background.png");
map_image = image(-180:180,90:-1:-90,rgb);
set(gca,'YDir','normal');
xlim([-180 180]);
ylim([-90 90]);
hold on;
plot(lon, lat, '.');
title('Ground Track');
xlabel('Longitude');
ylabel('Latitude');