function ui_dpops(dirfunc, stream)
% ui_dpops
% ui_dpops(dirfunc [, stream])
% dirfunc is a string specifying the name of a function
%   that specifies where data run directories are stored.
% stream is an optional argument specifying which stream
%   the run directories have recorded, e.g. 'SerIn'
if nargin < 1
  dirfunc = 'DPOPS_DATA_DIR';
end
if nargin >= 2
  f = ne_dialg(stream, 1);
else
  f = ne_dialg('DCOTSS POPS',1);
end
f = ne_dialg(f, 'add', 0, 1, 'gdpopsa', 'Algo' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsasws', 'SW Stat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsag', 'Gains' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsaf', 'Filter' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsamf', 'M Ffilt' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsalp', 'L Pper' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsaip', 'Iso Pct' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsasa', 'Sim Alt' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsdacsa', 'uDACS A' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsas', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsaais', 'AI Stat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsat', 'Temps' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsaain', 'AI N' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsms', 'MS5607' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsmsp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsmst', 'T' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsp', 'Pumps' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspt', 'Temps' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsps', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspbpv', 'B Pmp V' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gdpopspops', 'POPS' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopss', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsd', 'Drift' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopspn', 'Part Num' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsnum_cc', 'num cc' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopssurface', 'Surface' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsv', 'Volume' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsf', 'Flow' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsr', 'Raw ccs' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopst', 'T' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsb', 'Bins' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsm', 'Moudi' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsmc', 'Command' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsmstatus', 'Status' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gdpopsdacsb', 'uDACS B' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbais', 'AI Stat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbaics', 'AI Ch S' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbain', 'AI N' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbai', 'AI errs' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbr', 'Raw' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsi', 'Inlet' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsirt', 'Ring T' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiv', 'Velocity' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsinccm', 'NCCM' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsh', 'Honeywell' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopshs', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopshhpst', 'HPS T' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopshhpsp', 'HPS P' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopshhps_dp', 'HPS dP' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopstm', 'T Mbase' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopstmtd', 'T Drift' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopstmcpu', 'CPU' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopstmram', 'RAM' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopstmd', 'Disk' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gdpopsahk', 'Alicat HK' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsahks', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsahkstale', 'Stale' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsahkmbar', 'mbar' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsahkt', 'T' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsalicat', 'Alicat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsalicatnccm', 'nccm' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsalicatccm', 'ccm' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopspopshk', 'POPS HK' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopshkstd', 'STD' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopshkldt', 'LD Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopshkldm', 'LD Mon' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopshkb', 'Baseline' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopshks', 'Srvr' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopshkstale', 'Stale' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gdpopsiwg', 'IWG1' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwgl', 'Lat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwglon', 'Lon' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwgt', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwgp', 'Pres' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwgs', 'Speed' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwgm', 'Mach' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwga', 'Alt' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsattitude', 'Attitude' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattitudea', 'Attack' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattitudep', 'Pitch' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattituder', 'Roll' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattitudess', 'Side Slip' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattituded', 'Drift' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattitudesz', 'SZ' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattitudeaz', 'AZ' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattitude_az', 'Az' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsattitudet', 'Track' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gdpopsw', 'Wind' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopswvv', 'Vert Vel' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopswvs', 'Vert Speed' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopswd', 'Dir' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsws', 'Speed' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsiwg1_stat', 'IWG1 Stat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwg1_statcp', 'Cabin Press' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwg1_stattd', 'T Drift' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsiwg1_stats', 'Stale' );
f = ne_listdirs(f, dirfunc, 15);
f = ne_dialg(f, 'newcol');
ne_dialg(f, 'resize');
