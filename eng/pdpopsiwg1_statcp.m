function pdpopsiwg1_statcp(varargin);
% pdpopsiwg1_statcp( [...] );
% IWG1 Stat Cabin Press
h = timeplot({'Cabin_Press'}, ...
      'IWG1 Stat Cabin Press', ...
      'Cabin Press', ...
      {'Cabin\_Press'}, ...
      varargin{:} );