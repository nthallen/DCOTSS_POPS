function pdpopspt(varargin);
% pdpopspt( [...] );
% Pumps Temps
h = timeplot({'PPmpT','BPmpT'}, ...
      'Pumps Temps', ...
      'Temps', ...
      {'PPmpT','BPmpT'}, ...
      varargin{:} );
