function dfs_out = rt_dpgs(dfs)
% dfs = rt_dpgs()
%   Create a data_fields object and setup all the buttons for realtime
%   plots
% dfs_out = rt_dpgs(dfs)
%   Use the data_fields object and setup all the buttons for realtime plots
if nargin < 1 || isempty(dfs)
  dfs = data_fields('title', 'SABRE DPOPS PGS', ...
    'Color', [.8 .8 1], ...
    'h_leading', 8, 'v_leading', 2, ...
    'btn_fontsize', 12, ...
    'txt_fontsize', 12);
  context_level = dfs.rt_init;
else
  context_level = 1;
end
dfs.start_col;
dfs.plot('tm', 'label', 'T Mbase', 'plots', {'tmtd','tmcpu','tmram','tmd'});
dfs.plot('tmtd','label','T Drift','vars',{'SysTDrift'});
dfs.plot('tmcpu','label','CPU','vars',{'CPU_Pct'});
dfs.plot('tmram','label','RAM','vars',{'memused'});
dfs.plot('tmd','label','Disk','vars',{'Disk'});
dfs.plot('s', 'label', 'Status', 'plots', {'ss','sd','sstatus'});
dfs.plot('ss','label','Stale','vars',{'UDPtxin_Stale'});
dfs.plot('sd','label','Drift','vars',{'UDPdrift'});
dfs.plot('sstatus','label','Status','vars',{'InstS'});
dfs.plot('pops', 'label', 'POPS', 'plots', {'popsn','popsa','popsf','popst','popsp'});
dfs.plot('popsn','label','N','vars',{'POPS_num_cc'});
dfs.plot('popsa','label','Area','vars',{'POPS_Surf_Area'});
dfs.plot('popsf','label','Flow','vars',{'POPS_ccm'});
dfs.plot('popst','label','Temp','vars',{'POPS_Temp'});
dfs.plot('popsp','label','Pres','vars',{'POPS_P_mbar'});
dfs.plot('hk', 'label', 'HK', 'plots', {'hkp','hkt'});
dfs.plot('hkp','label','Pres','vars',{'POPS_P_mbar','HPS_P','MS5607_P'});
dfs.plot('hkt','label','Temp','vars',{'POPS_Temp','Amb_T','PPmpT'});
dfs.end_col;
dfs.set_connection('127.0.0.1', 1376);
if nargout > 0
  dfs_out = dfs;
else
  dfs.resize(context_level);
end
