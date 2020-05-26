%INTERFACE <POPS>

&command
  : POPS Shutdown * { if_POPS.Turf("S\n"); }
  : POPS Quit * { if_POPS.Turf("Q\n"); }
  ;
