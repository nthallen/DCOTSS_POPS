function pdpopsdacsas(varargin);
% pdpopsdacsas( [...] );
% uDACS A Status
h = ne_dstat({
  'Fail', 'Fail', 0; ...
	'Alert', 'uDACS_A_stat0', 7 }, 'Status', varargin{:} );
