function pdpopsrtcelapsed(varargin);
% pdpopsrtcelapsed( [...] );
% RTC elapsed
h = timeplot({'uDACS_A_elapsed_d','uDACS_B_elapsed_d'}, ...
      'RTC elapsed', ...
      'elapsed', ...
      {'uDACS\_A\_elapsed\_d','uDACS\_B\_elapsed\_d'}, ...
      varargin{:} );
