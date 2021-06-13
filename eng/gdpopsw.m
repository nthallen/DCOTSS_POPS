function fig = gdpopsw(varargin);
% gdpopsw(...)
% Wind
ffig = ne_group(varargin,'Wind','pdpopswvv','pdpopswvs','pdpopswd','pdpopsws');
if nargout > 0 fig = ffig; end
