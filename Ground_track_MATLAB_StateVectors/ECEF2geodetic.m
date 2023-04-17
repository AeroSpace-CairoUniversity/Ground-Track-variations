function [lat, lon, h] = ECEF2geodetic(x, y, z, a, e)

% Convert ECEF coordinates to geodetic coordinates
%
% INPUTS:
% x, y, z: ECEF coordinates in meters
% a: semi-major axis of the reference ellipsoid in meters
% e: eccentricity of the reference ellipsoid
%
% OUTPUTS:
% lat: geodetic latitude in degrees
% lon: geodetic longitude in degrees
% h: geodetic height in meters

% Compute flattening
f = 1 - sqrt(1 - e^2);

% Compute longitude
lon = atan2(y, x);

% Compute distance from z-axis
r = sqrt(x.^2 + y.^2);

% Compute latitude
lat = atan2(z, r.*(1 - f) + e^2.*z);

% Compute prime vertical radius of curvature
N = a./sqrt(1 - e^2.*sin(lat).^2);

% Compute geodetic height
h = r.*cos(lat) + z.*sin(lat) - N.*(1 - e^2);

% Convert latitude and longitude to degrees
lat = rad2deg(lat);
lon = rad2deg(lon);
end
