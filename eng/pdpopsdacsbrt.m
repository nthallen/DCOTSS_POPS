function pdpopsdacsbrt(varargin);
% pdpopsdacsbrt( [...] );
% uDACS B Ring T
h = timeplot({'Ring1T','Ring2T','Ring3T'}, ...
      'uDACS B Ring T', ...
      'Ring T', ...
      {'Ring1T','Ring2T','Ring3T'}, ...
      varargin{:} );