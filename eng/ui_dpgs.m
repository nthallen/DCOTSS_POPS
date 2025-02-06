function ui_dpgs(dirfunc, stream)
% ui_dpgs
% ui_dpgs(dirfunc [, stream])
% dirfunc is a string specifying the name of a function
%   that specifies where data run directories are stored.
% stream is an optional argument specifying which stream
%   the run directories have recorded, e.g. 'SerIn'
if nargin < 1
  dirfunc = 'DPOPS_PGS_DATA_DIR';
end
if nargin >= 2
  f = ne_dialg(stream, 1);
else
  f = ne_dialg('SABRE DPOPS PGS',1);
end
f = ne_dialg(f, 'add', 0, 1, 'gdpgstm', 'T Mbase' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgstmtd', 'T Drift' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgstmcpu', 'CPU' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgstmram', 'RAM' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgstmd', 'Disk' );
f = ne_dialg(f, 'add', 0, 1, 'gdpgss', 'Status' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgsss', 'Stale' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgssd', 'Drift' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgssstatus', 'Status' );
f = ne_dialg(f, 'add', 0, 1, 'gdpgspops', 'POPS' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgspopsn', 'N' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgspopsa', 'Area' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgspopsf', 'Flow' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgspopst', 'Temp' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgspopsp', 'Pres' );
f = ne_dialg(f, 'add', 0, 1, 'gdpgshk', 'HK' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgshkp', 'Pres' );
f = ne_dialg(f, 'add', 1, 0, 'pdpgshkt', 'Temp' );
f = ne_listdirs(f, dirfunc, 15);
f = ne_dialg(f, 'newcol');
ne_dialg(f, 'resize');
