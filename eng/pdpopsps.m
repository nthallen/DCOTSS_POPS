function pdpopsps(varargin);
% pdpopsps( [...] );
% Pumps Status
h = ne_dstat({
  'PPmpCmd', 'HPS_Stat', 0; ...
	'PPmpS', 'HPS_Stat', 1; ...
	'BPmpCmd', 'HPS_Stat', 2; ...
	'BPmpS', 'HPS_Stat', 0 }, 'Status', varargin{:} );