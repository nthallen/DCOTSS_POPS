function pdpopsattituder(varargin);
% pdpopsattituder( [...] );
% Attitude Roll
h = timeplot({'Roll'}, ...
      'Attitude Roll', ...
      'Roll', ...
      {'Roll'}, ...
      varargin{:} );
