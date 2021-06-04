tmcbase = base.tmc
tmcbase = uDACS.tmc
tmcbase = uDACS_A.tmc
tmcbase = uDACS_B.tmc
tmcbase = T30K75KU_uDACS.tmc
tmcbase = T30K75KU_uDACS16.tmc
tmcbase = AD7770_T10K100KU.tmc
tmcbase = uDACS_A_conv.tmc uDACS_B_conv.tmc

colbase = uDACS_col.tmc
colbase = uDACS_A_col.tmc
colbase = uDACS_B_col.tmc

genuibase = DPOPS.genui
genuibase = uDACS.genui

cmdbase = playback.cmd
cmdbase = uDACS.cmd
cmdbase = LFE.cmd

swsbase = DPOPS.sws

Module TMbase
Module alicat src=alicat.txt
Module POPS

TGTDIR = /home/DPOPS
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services interact runfile.flight
DISTRIB = USB_ID.exp
IDISTRIB = doit

DPOPScol : -lsubbuspp
DPOPSsrvr : -lsubbuspp uDACS_cmd.oui
DPOPSdisp : DPOPS.tbl POPS.tbl uDACS.tbl
uDACSdisp : uDACS.tbl
DPOPSalgo : DPOPS.tma DPOPS.sws
UDPext : UDP.tmc UDP.cc
doit : DPOPS.doit
%%
# This matches the current definitions in monarch dasio
# and is necessary to see addrinfo/getaddrinfo needed for
# UDP.
CXXFLAGS=-Wall -g -D_POSIX_C_SOURCE=200809L
