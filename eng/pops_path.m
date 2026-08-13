%% pops_path.m
% Interactive 3D globe view (rotate / pan / tilt / zoom with the mouse,
% just like Google Earth) of POPS aerosol concentration, restricted to
% samples above 8,000 ft altitude.
%
% Requires MATLAB R2020a or later WITH the Mapping Toolbox installed
% (uifigure is base MATLAB, but geoglobe/geoplot3 are Mapping Toolbox
% functions).
%
% Data source: dpopseng_1.mat
%
% OPTIONS:
%  Altitude Threshold (Floor) Line 34
%  Log/Linear Scale (true/false) Line 56
%  Scale Limits Line 57
%
%   Lat, Lon      - degrees
%   GPS_MSL_Alt   - meters, mean sea level
%   POPS_num_cc   - particles / cm^3

clear; clc; close all;

%% --- Load data ----------------------------------------------------------
data = load('dpopseng_1.mat');

lat  = data.Lat(:);
lon  = data.Lon(:);
alt  = data.GPS_MSL_Alt(:);      % meters MSL
pops = data.POPS_num_cc(:);      % particles/cc

%% --- Clean up invalid samples --------------------------------------------
valid = ~isnan(lat) & ~isnan(lon) & ~isnan(alt) & ~isnan(pops);
lat  = lat(valid);
lon  = lon(valid);
alt  = alt(valid);
pops = pops(valid);

%% --- Filter: keep only samples above 25,000 ft ---------------------------
altThreshold_ft = 8000;
altThreshold_m  = altThreshold_ft * 0.3048;   % 13,716 m

highAlt = alt > altThreshold_m;

fprintf('%d of %d samples are above %.0f ft (%.1f m)\n', ...
    sum(highAlt), numel(valid), altThreshold_ft, altThreshold_m);

lat  = lat(highAlt);
lon  = lon(highAlt);
alt  = alt(highAlt);
pops = pops(highAlt);

%% --- Choose color scale -----------------------------------------------
% Focus the color range on 1-10 cm^-3 to make spikes in that band stand
% out: values below 1 clamp to the bottom color, values above 10 clamp
% to the top color, and the full colormap contrast is used within [1,10].
useLogScale  = true;    % set true for log-scaled color, false for linear
colorLimits  = [1, 1000];  % cm^-3 - edit this range to refocus on other bands

popsPlot  = pops;
colorVals = min(max(popsPlot, colorLimits(1)), colorLimits(2));  % clamp

if useLogScale
    colorVals = log10(max(colorVals, 1e-6));
    colorEdgeLimits = log10(colorLimits);
else
    colorEdgeLimits = colorLimits;
end

%% --- Bin the concentration into color groups -------------------------------
% geoplot3 (unlike scatter3) only supports one color per call, so a
% continuous colormap effect is built manually: bin the data, then plot
% each bin separately with its own color.
nBins   = 32;
edges   = linspace(colorEdgeLimits(1), colorEdgeLimits(2), nBins + 1);
binIdx  = discretize(colorVals, edges);
binIdx(colorVals <= edges(1))   = 1;      % catch clamped-low values
binIdx(colorVals >= edges(end)) = nBins;  % catch clamped-high values
cmap    = turbo(nBins);

%% --- Create the interactive 3D globe --------------------------------------
uif = uifigure('Name', 'ER-2 POPS Track (>8,000 ft)', 'Position', [100 100 1050 780]);
g = geoglobe(uif);
hold(g, 'on');

% Plot the flight path as a continuous line first, so the colored
% concentration markers sit visually on top of it.
pathColor     = [0.85 0.85 0.85];   % light gray - edit to taste
pathLineWidth = 4;                  % increase for a thicker path

geoplot3(g, lat, lon, alt, '-', ...
    'Color', pathColor, ...
    'LineWidth', pathLineWidth, ...
    'Marker', 'none');

% Plot each color bin as its own set of markers on top of the path.
% Note: on a geoglobe, geoplot3 returns a specialized Line object whose
% Marker property only accepts 'o' or 'none' - there is no MarkerFaceColor
% or other fill property at all. The workaround: since LineWidth also
% thickens the marker's edge, using a LineWidth close to the MarkerSize
% makes the ring's stroke fill in the center, giving a solid-looking dot.
markerSize      = 5;   % reduce/increase to change dot size
markerLineWidth = 4;   % keep close to markerSize so dots look solid, not ringed

for k = 1:nBins
    idx = (binIdx == k);
    if any(idx)
        geoplot3(g, lat(idx), lon(idx), alt(idx), 'o', ...
            'Color', cmap(k, :), ...
            'MarkerSize', markerSize, ...
            'LineWidth', markerLineWidth, ...
            'LineStyle', 'none');
    end
end

% Point the camera at the mean location of the high-altitude segment.
% After this, use the mouse to rotate/pan/tilt/zoom freely (left-drag =
% rotate, right-drag = tilt, scroll = zoom - same feel as Google Earth).
campos(g, mean(lat), mean(lon), 4e5);   % ~400 km camera altitude to start
camheading(g, 0);
campitch(g, -60);

%% --- Colorbar reference window ---------------------------------------
% geoglobe is a web-based component that renders on top of everything
% else in its own uifigure, so a colorbar placed in that same window
% gets hidden underneath it. Instead, show the color scale in its own
% separate, ordinary figure window next to the globe.
cbFig = figure('Name', 'POPS Concentration Scale', 'Color', 'w', ...
    'Position', [1160 100 170 700]);
axis off;

colormap(cbFig, turbo);
caxis(colorLimits);
if useLogScale
    set(gca, 'ColorScale', 'log');   % R2021b+
end

cb = colorbar('Location', 'west');
cb.Position = [0.35 0.05 0.3 0.9];
cb.Label.String = 'POPS particle number concentration (cm^{-3})';
cb.Label.FontSize = 11;

