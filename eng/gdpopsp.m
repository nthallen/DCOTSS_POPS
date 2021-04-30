function fig = gdpopsp(varargin);
% gdpopsp(...)
% Pumps
ffig = ne_group(varargin,'Pumps','pdpopspt','pdpopsps','pdpopspbpv');
if nargout > 0 fig = ffig; end
