function pdpopsahkmbar(varargin);
% pdpopsahkmbar( [...] );
% Alicat HK mbar
h = timeplot({'BMFC_P','PMFC_P','MMFC_P'}, ...
      'Alicat HK mbar', ...
      'mbar', ...
      {'BMFC\_P','PMFC\_P','MMFC\_P'}, ...
      varargin{:} );
