function pdpopspt(varargin);
% pdpopspt( [...] );
% Pumps Temps
h = timeplot({'Pmp1T','Pmp2T'}, ...
      'Pumps Temps', ...
      'Temps', ...
      {'Pmp1T','Pmp2T'}, ...
      varargin{:} );
