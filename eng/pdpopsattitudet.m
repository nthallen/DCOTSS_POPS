function pdpopsattitudet(varargin)
% pdpopsattitudet( [...] );
% Attitude Track
h = timeplot({'Track','True_Hdg'}, ...
      'Attitude Track', ...
      'Track', ...
      {'Track','True\_Hdg'}, ...
      varargin{:} );
