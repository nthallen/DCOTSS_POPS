tmcbase = base.tmc
tmcbase = uDACS.tmc
tmcbase = uDACS_A.tmc
tmcbase = uDACS_B.tmc
# kluge to define Sim_Vel before referencing it in uDACS_B_conv.tmc
tmcbase = SWData.tmc
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
Module alicat mode=ignore src=alicat.txt
tmcbase = Alicat_conv.tmc LowPass.cc
Module POPS
Module IWG1

TGTDIR = /home/DPOPS
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services interact runfile.flight
DISTRIB = USB.id Rovers.txt
IDISTRIB = doit POPSdata

DPOPScol : -lsubbuspp
DPOPSsrvr : -lsubbuspp uDACS_cmd.oui
DPOPSdisp : DPOPS.tbl POPS.tbl uDACS.tbl
uDACSdisp : uDACS.tbl
IWG1disp : IWG1.tbl
DPOPSalgo : DPOPS.tma DPOPS.sws
UDPext : UDP.tmc UDP.cc UDPext.oui
DPOPSjsonext : $extbase $genuibase
doit : DPOPS.doit
%%
# This matches the current definitions in monarch dasio
# and is necessary to see addrinfo/getaddrinfo needed for
# UDP.
CXXFLAGS=-Wall -g -D_POSIX_C_SOURCE=200809L
