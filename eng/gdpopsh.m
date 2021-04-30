function fig = gdpopsh(varargin);
% gdpopsh(...)
% Honeywell
ffig = ne_group(varargin,'Honeywell','pdpopshs','pdpopshhpst','pdpopshhpsp','pdpopshhps_dp');
if nargout > 0 fig = ffig; end
