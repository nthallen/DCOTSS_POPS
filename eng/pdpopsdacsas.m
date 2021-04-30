function pdpopsdacsas(varargin);
% pdpopsdacsas( [...] );
% uDACS A Status
h = ne_dstat({
  'Fail', 'Fail', 0; ...
	'Mode', 'Fail', 4 }, 'Status', varargin{:} );
