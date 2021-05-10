function ui_dpops
f = ne_dialg('DCOTSS POPS',1);
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
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsstd', 'STD' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsp', 'P' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsf', 'Flow' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsldt', 'LD Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsldm', 'LD Mon' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopst', 'T' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsb', 'Bins' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopssrvr', 'Srvr' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopsstale', 'Stale' );
f = ne_dialg(f, 'add', 0, 1, 'gdpopsdacsb', 'uDACS B' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbais', 'AI Stat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbaics', 'AI Ch S' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbain', 'AI N' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbai', 'AI errs' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsbr', 'Raw' );
f = ne_dialg(f, 'newcol');
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
f = ne_dialg(f, 'add', 0, 1, 'gdpopsahk', 'Alicat HK' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsahks', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsahkstale', 'Stale' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsahkt', 'T' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsahkmbar', 'mbar' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gdpopsa', 'Alicat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsanccm', 'nccm' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsaccm', 'ccm' );
f = ne_listdirs(f, 'DPOPS_DATA_DIR', 15);
f = ne_dialg(f, 'newcol');
ne_dialg(f, 'resize');
