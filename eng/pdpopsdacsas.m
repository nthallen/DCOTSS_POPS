function pdpopsdacsas(varargin)
% pdpopsdacsas( [...] );
% uDACS A Status
h = ne_dstat({
  'Fail', 'FailMode', 0; ...
	'Mode', 'FailMode', 4 }, 'Status', varargin{:} );
