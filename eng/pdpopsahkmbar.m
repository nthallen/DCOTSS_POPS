function pdpopsahkmbar(varargin);
% pdpopsahkmbar( [...] );
% Alicat HK mbar
h = timeplot({'MFC1_P','MFC2_P'}, ...
      'Alicat HK mbar', ...
      'mbar', ...
      {'MFC1\_P','MFC2\_P'}, ...
      varargin{:} );