function pdpopsanccm(varargin);
% pdpopsanccm( [...] );
% Alicat nccm
h = timeplot({'MFC1_Set','MFC1_MassFlow','MFC2_Set','MFC2_MassFlow'}, ...
      'Alicat nccm', ...
      'nccm', ...
      {'MFC1\_Set','MFC1\_MassFlow','MFC2\_Set','MFC2\_MassFlow'}, ...
      varargin{:} );
