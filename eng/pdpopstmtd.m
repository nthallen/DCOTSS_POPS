function pdpopstmtd(varargin)
% pdpopstmtd( [...] );
% T Mbase T Drift
h = timeplot({'SysTDrift'}, ...
      'T Mbase T Drift', ...
      'T Drift', ...
      {'SysTDrift'}, ...
      varargin{:} );
