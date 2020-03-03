function fig = gengpops(varargin);
% gengpops(...)
% POPS
ffig = ne_group(varargin,'POPS','pengpopsd','pengpopspn','pengpopsnum_cc','pengpopsstd','pengpopsp','pengpopsf','pengpopsldt','pengpopsldm','pengpopst','pengpopsb','pengpopss');
if nargout > 0 fig = ffig; end
