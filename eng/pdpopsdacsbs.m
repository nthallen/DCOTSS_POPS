function pdpopsdacsbs(varargin);
% pdpopsdacsbs( [...] );
% uDACS B Status
h = ne_dstat({
  'Fail', 'Fail', 0; ...
	'Alert', 'uDACS_B_stat0', 7 }, 'Status', varargin{:} );
