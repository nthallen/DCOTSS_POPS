function pdpopsag(varargin)
% pdpopsag( [...] );
% Algo Gains
h = timeplot({'LFE_PGain','LFE_IGain','BPmp_PGain','BPmp_IGain'}, ...
      'Algo Gains', ...
      'Gains', ...
      {'LFE\_PGain','LFE\_IGain','BPmp\_PGain','BPmp\_IGain'}, ...
      varargin{:} );
