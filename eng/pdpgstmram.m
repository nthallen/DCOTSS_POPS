function pdpgstmram(varargin)
% pdpgstmram( [...] );
% T Mbase RAM
h = timeplot({'memused'}, ...
      'T Mbase RAM', ...
      'RAM', ...
      {'memused'}, ...
      varargin{:} );
