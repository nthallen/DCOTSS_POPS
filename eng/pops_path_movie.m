%% pops_path_movie.m
% Animated "flight tracker" movie of POPS aerosol concentration, restricted
% to samples above an altitude threshold. Traces the flight path across a
% 2D map, synced with a scrolling altitude/total-concentration panel and a
% per-size-bin concentration panel (with legend) below it. Exported as an
% MP4 and/or GIF.
%
% This uses a 2D geoaxes map rather than the interactive 3D geoglobe from
% pops_path.m - geoglobe is a web-rendered uifigure control that doesn't
% reliably capture frame-by-frame with getframe, so geoaxes (normal,
% capturable axes) is used instead to make the export robust.
%
% Requires MATLAB R2020a or later WITH the Mapping Toolbox installed
% (geoaxes/geoplot/geoscatter are Mapping Toolbox functions).
%
% Data source: dpopseng_1.mat
%   Lat, Lon      - degrees
%   GPS_MSL_Alt   - meters, mean sea level
%   POPS_num_cc   - particles / cm^3
%   individual size-bin fields, auto-detected below (see binFieldNames)
%
% ------------------------- OPTIONS (edit these) -------------------------
altThreshold_ft = 8000;        % altitude floor for included samples (ft)
useLogScale     = true;        % true/false - color scale for POPS conc.
colorLimits     = [1, 1000];   % cm^-3 range for the color scale

% --- SPEED CONTROLS ---
% Rendering time is driven almost entirely by nFrames (= nSamples /
% frameStep). Raising frameStep is the single biggest lever for a faster
% render. fps only changes how fast the finished video PLAYS BACK - it
% does not speed up rendering.
frameStep       = 10;          % use every Nth sample as an animation frame
fps             = 20;          % playback frame rate
outputFormat    = 'mp4';       % 'mp4' | 'gif' | 'both'
                                % GIF is noticeably slower to write (each
                                % frame gets re-quantized to a 256-color
                                % palette) - use 'mp4' unless you specifically
                                % need a GIF, and add 'both' back once
                                % you're happy with the framing/speed.
outFileName     = 'pops_flight_movie';  % base name, no extension

% Bin-panel fields: auto-detected below by name pattern (b1, bin1, b01...).
% If your .mat file's bin fields use different names, or you want to
% override the auto-detected list/order, set binFieldNames manually here,
% e.g. binFieldNames = {'b1','b2','b3',...}; leave empty ({}) to keep
% auto-detection.
binFieldNames   = {};
% --------------------------------------------------------------------

clearvars -except altThreshold_ft useLogScale colorLimits frameStep fps ...
              outputFormat outFileName binFieldNames;
clc; close all;

%% --- Load data ----------------------------------------------------------
data = load('dpopseng_1.mat');

lat  = data.Lat(:);
lon  = data.Lon(:);
alt  = data.GPS_MSL_Alt(:);      % meters MSL
pops = data.POPS_num_cc(:);      % particles/cc

% Time: seconds since midnight UTC, via time2d (same as UCATS_moudivalve.m)
time = time2d(data.Tdpopseng_1(:));

%% --- Clean up invalid samples --------------------------------------------
valid = ~isnan(lat) & ~isnan(lon) & ~isnan(alt) & ~isnan(pops) & ~isnan(time);

%% --- Filter: keep only samples above threshold ---------------------------
altThreshold_m = altThreshold_ft * 0.3048;
highAlt_full = alt > altThreshold_m;   % evaluated pre-mask, applied together below
keep = valid & highAlt_full;

fprintf('%d of %d samples kept (valid + above %.0f ft / %.1f m)\n', ...
    sum(keep), numel(lat), altThreshold_ft, altThreshold_m);

lat  = lat(keep);
lon  = lon(keep);
alt  = alt(keep);
pops = pops(keep);
time = time(keep);   % seconds since midnight UTC, drift-corrected

nSamples = numel(lat);
if nSamples < 2
    error('Not enough valid samples above the altitude threshold to animate.');
end

% Sample index is used as the "time" axis below. POPST turned out to be
% POPS instrument temperature (~22 C), not a timestamp, so there's no
% confirmed real time field to use yet - swap elapsedIdx out once you've
% identified the correct one.
elapsedIdx = (1:nSamples)';

%% --- Auto-detect POPS size-bin fields --------------------------------------
if isempty(binFieldNames)
    allFields = fieldnames(data);
    % Matches names ending in "Bin" + digits, e.g. POPS_Bin01, POPS_Bin16
    binMask   = ~cellfun('isempty', regexpi(allFields, 'bin0*\d+$'));
    binFieldNames = allFields(binMask);
end

if isempty(binFieldNames)
    warning(['No POPS bin fields auto-detected (looking for names ending ' ...
        'in "Bin" + digits, e.g. POPS_Bin01). Set binFieldNames manually ' ...
        'near the top of this script, e.g. binFieldNames = {''POPS_Bin01'',...};']);
    binNums = [];
else
    binNums = cellfun(@(s) str2double(regexp(s, '\d+', 'match', 'once')), binFieldNames);
    [binNums, sortOrder] = sort(binNums);
    binFieldNames = binFieldNames(sortOrder);
end

nBinsFound = numel(binFieldNames);
binData = nan(nSamples, nBinsFound);
for b = 1:nBinsFound
    col = data.(binFieldNames{b})(:);
    col = col(keep);
    binData(:, b) = col;
end

% POPS default 16-bin size boundaries (nm), from the instrument spec sheet.
% popsBinLower(n)/popsBinUpper(n) give the diameter range for Bin n.
popsBinLower = [115 125 135 150 165 185 210 250 350 475 575  855 1220 1530 1990 2585];
popsBinUpper = [125 135 150 165 185 210 250 350 475 575 855 1220 1530 1990 2585 3370];

binLabels = cell(size(binNums));
for ii = 1:numel(binNums)
    n = binNums(ii);
    if n >= 1 && n <= 16
        binLabels{ii} = sprintf('%d-%d nm', popsBinLower(n), popsBinUpper(n));
    else
        % Fallback for any bin number outside the standard 16-bin table
        % (e.g. a different bin configuration) - edit popsBinLower/Upper
        % above to match if your instrument used a non-default setting.
        binLabels{ii} = sprintf('Bin %d', n);
    end
end

fprintf('Bin panel: %d size-bin fields detected: %s\n', nBinsFound, ...
    strjoin(binFieldNames, ', '));

%% --- Color mapping for POPS concentration --------------------------------
popsClamped = min(max(pops, colorLimits(1)), colorLimits(2));
if useLogScale
    colorVals   = log10(max(popsClamped, 1e-6));
    colorLimLog = log10(colorLimits);
else
    colorVals   = popsClamped;
    colorLimLog = colorLimits;
end

cmap     = turbo(256);
cIdx     = round(rescale(colorVals, 1, 256, ...
                  'InputMin', colorLimLog(1), 'InputMax', colorLimLog(2)));
cIdx     = min(max(cIdx, 1), 256);
ptColors = cmap(cIdx, :);

%% --- Frames to render -----------------------------------------------------
frameSamples = 2:frameStep:nSamples;
if frameSamples(end) ~= nSamples
    frameSamples(end+1) = nSamples;   % always include the final point
end
nFrames = numel(frameSamples);

% IMPORTANT SPEED FIX vs. the previous version: the trail is now built
% from only the decimated frame samples (nFrames points total), not every
% raw sample up to the current index. Previously the scatter trail redrew
% the full dense sample history (up to nSamples points) every frame
% regardless of frameStep, which is what made rendering slow.
plotLat    = lat(frameSamples);
plotLon    = lon(frameSamples);
plotColors = ptColors(frameSamples, :);

fprintf('Rendering %d frames (every %d-th sample of %d total)...\n', ...
    nFrames, frameStep, nSamples);

%% --- Build the figure layout ----------------------------------------------
fig = figure('Color', 'w', 'Position', [100 100 1000 950]);
tl  = tiledlayout(fig, 5, 1, 'TileSpacing', 'compact', 'Padding', 'compact');

% -- Map panel (top 3 rows) --
axMap = geoaxes(tl);
axMap.Layout.Tile     = 1;
axMap.Layout.TileSpan = [3 1];
geobasemap(axMap, 'topographic');   % swap to 'grayland' for a faster,
                                     % offline-friendly vector basemap
hold(axMap, 'on');
title(axMap, 'ER-2 Flight Track - POPS Number Concentration');

% Full flight path in light gray for context, visible from frame 1.
geoplot(axMap, lat, lon, '-', 'Color', [0.75 0.75 0.75], 'LineWidth', 1.5);

% Handles updated every frame: growing colored trail + a bright "current
% position" marker riding at the head of it.
trailPlot = geoscatter(axMap, plotLat(1), plotLon(1), 18, plotColors(1,:), 'filled');
headPlot  = geoplot(axMap, plotLat(1), plotLon(1), 'o', 'MarkerSize', 10, ...
    'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', [0 0 0], 'LineWidth', 1.5);

colormap(axMap, turbo);
clim(axMap, colorLimLog);
cb = colorbar(axMap);
cb.Label.String = 'POPS concentration (cm^{-3})';
if useLogScale
    cb.Ticks = colorLimLog(1):1:colorLimLog(2);
    cb.TickLabels = arrayfun(@(v) sprintf('%.0f', 10^v), cb.Ticks, ...
        'UniformOutput', false);
end

% -- Altitude + total POPS panel (row 4) --
axTS = nexttile(tl, 4);
yyaxis(axTS, 'left');
plot(axTS, time, alt/0.3048, '-', 'Color', [0.3 0.3 0.7]);
ylabel(axTS, 'Altitude (ft)');
yyaxis(axTS, 'right');
plot(axTS, time, pops, '-', 'Color', [0.7 0.3 0.3]);
if useLogScale
    set(axTS, 'YScale', 'log');
end
ylabel(axTS, 'Total POPS (cm^{-3})');
xlim(axTS, [min(time) max(time)]);
grid(axTS, 'on');
cursorLine = xline(axTS, min(time), 'k-', 'LineWidth', 1.5);

% -- Per-bin concentration panel with legend (row 5) --
axBins = nexttile(tl, 5);
hold(axBins, 'on');
if nBinsFound > 0
    binColors = turbo(nBinsFound);
    for b = 1:nBinsFound
        plot(axBins, time, binData(:, b), '-', 'Color', binColors(b, :));
    end
    legend(axBins, binLabels, 'Location', 'eastoutside', 'FontSize', 7, ...
        'NumColumns', ceil(nBinsFound/8));
    set(axBins, 'YScale', 'log');
else
    text(axBins, 0.5, 0.5, 'No bin fields found - set binFieldNames manually', ...
        'Units', 'normalized', 'HorizontalAlignment', 'center');
end
ylabel(axBins, 'Bin conc. (cm^{-3})');
xlabel(axBins, 'Time (UTC, HH:MM)');
xlim(axBins, [min(time) max(time)]);
grid(axBins, 'on');
cursorLine2 = xline(axBins, min(time), 'k-', 'LineWidth', 1.5);
linkaxes([axTS axBins], 'x');

% Format tick labels as HH:MM UTC instead of raw seconds-since-midnight.
xticklabels(axTS, secToClockStr(xticks(axTS)));
xticklabels(axBins, secToClockStr(xticks(axBins)));

%% --- Set up video/gif writers ----------------------------------------------
writeMP4 = any(strcmpi(outputFormat, {'mp4', 'both'}));
writeGIF = any(strcmpi(outputFormat, {'gif', 'both'}));

if writeMP4
    if ispc || ismac
        vw = VideoWriter([outFileName '.mp4'], 'MPEG-4');
    else
        % The MPEG-4 VideoWriter profile isn't available on Linux - fall
        % back to an AVI container (still a normal playable video file).
        vw = VideoWriter([outFileName '.avi'], 'Motion JPEG AVI');
        warning('MPEG-4 not supported on this platform - writing an AVI instead.');
    end
    vw.FrameRate = fps;
    open(vw);
end
gifFile = [outFileName '.gif'];

%% --- Animate + capture ------------------------------------------------------
for f = 1:nFrames
    k = frameSamples(f);

    set(trailPlot, 'LatitudeData', plotLat(1:f), 'LongitudeData', plotLon(1:f), ...
        'CData', plotColors(1:f, :));
    set(headPlot, 'LatitudeData', lat(k), 'LongitudeData', lon(k));
    cursorLine.Value  = time(k);
    cursorLine2.Value = time(k);

    drawnow;
    frame = getframe(fig);

    if writeMP4
        writeVideo(vw, frame);
    end
    if writeGIF
        [imind, cmapGif] = rgb2ind(frame.cdata, 256);
        if f == 1
            imwrite(imind, cmapGif, gifFile, 'gif', 'Loopcount', inf, ...
                'DelayTime', 1/fps);
        else
            imwrite(imind, cmapGif, gifFile, 'gif', 'WriteMode', 'append', ...
                'DelayTime', 1/fps);
        end
    end
end

if writeMP4
    close(vw);
    fprintf('Saved %s\n', vw.Filename);
end
if writeGIF
    fprintf('Saved %s\n', gifFile);
end

%% --- Local functions --------------------------------------------------------
function labels = secToClockStr(secVals)
% Format seconds-since-midnight as 'HH:MM' UTC strings for axis ticks.
secVals = mod(secVals, 86400);
hh = floor(secVals / 3600);
mm = round(mod(secVals, 3600) / 60);
mm(mm == 60) = 0;
labels = arrayfun(@(h, m) sprintf('%02d:%02d', h, m), hh, mm, 'UniformOutput', false);
end

function tout = time2d(t, m, s)
% tout = time2d(t);
% t is seconds since 1970 UTC
% tout is seconds since midnight UTC
%
% tout = time2d(h,m,s);
% tout is seconds
if nargin == 1
    t1 = t(find(~isnan(t), 1));
    day = fix(t1./(24*60*60));
    tout = t - day*60*24*60;
else
    tout = t*3600 + m*60 + s;
end
end