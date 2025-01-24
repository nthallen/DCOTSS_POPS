function pdpopspopss(varargin)
% pdpopspopss( [...] );
% POPS Status
h = ne_dstat({
  'POPSPwr', 'PwrStat', 3 }, 'Status', varargin{:} );
