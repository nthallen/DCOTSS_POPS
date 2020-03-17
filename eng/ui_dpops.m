function ui_dpops
f = ne_dialg('DCOTSS POPS',1);
f = ne_dialg(f, 'add', 0, 1, 'gdpopsdacsa', 'uDACS A' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsadac', 'DAC' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsas', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsav', 'V' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsah', 'Hdrs' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsdacsan', 'N' );
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
f = ne_dialg(f, 'add', 0, 1, 'gdpopsa', 'Alicat' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsaccm', 'ccm' );
f = ne_dialg(f, 'add', 1, 0, 'pdpopsasccm', 'sccm' );
f = ne_dialg(f, 'newcol');
f = ne_dialg(f, 'add', 0, 1, 'gdpopspops', 'POPS' );
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
f = ne_dialg(f, 'add', 1, 0, 'pdpopspopss', 'Stale' );
f = ne_listdirs(f, 'DPOPS_DATA_DIR', 15);
f = ne_dialg(f, 'newcol');
ne_dialg(f, 'resize');
