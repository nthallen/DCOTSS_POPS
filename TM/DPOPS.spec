tmcbase = base.tmc
tmcbase = uDACS.tmc
tmcbase = uDACS_A.tmc
tmcbase = uDACS_B.tmc
colbase = uDACS_col.tmc
colbase = uDACS_A_col.tmc
colbase = uDACS_B_col.tmc
genuibase = DPOPS.genui
genuibase = uDACS.genui
extbase = uDACS_A_conv.tmc
extbase = uDACS_B_conv.tmc
cmdbase = playback.cmd
cmdbase = uDACS.cmd
swsbase = DPOPS.sws

Module TMbase
Module alicat src=alicat.txt
Module POPS

TGTDIR = /home/DPOPS
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services interact
DISTRIB = USB_ID.exp
IDISTRIB = doit

DPOPScol : -lsubbuspp
DPOPSsrvr : -lsubbuspp uDACS_cmd.oui
DPOPSdisp : uDACS_A_conv.tmc uDACS_B_conv.tmc DPOPS.tbl POPS.tbl uDACS.tbl
uDACSdisp : uDACS_A_conv.tmc uDACS_B_conv.tmc uDACS.tbl
DPOPSalgo : DPOPS.tma
madedoit : DPOPS.doit
%%
CXXFLAGS=-Wall -g
