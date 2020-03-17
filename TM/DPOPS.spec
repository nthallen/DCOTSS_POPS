tmcbase = base.tmc
tmcbase = uDACS.tmc
tmcbase = uDACS_A.tmc
colbase = uDACS_col.tmc
genuibase = DPOPS.genui
genuibase = uDACS.genui
extbase = uDACS_A_conv.tmc
cmdbase = playback.cmd

Module TMbase
Module alicat src=alicat.txt
Module POPS

TGTDIR = /home/DPOPS
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services interact
IDISTRIB = doit

DPOPScol : -lsubbuspp
DPOPSdisp : uDACS_A_conv.tmc DPOPS.tbl POPS.tbl uDACS.tbl
DPOPSalgo : DPOPS.tma
madedoit : DPOPS.doit
%%
CXXFLAGS=-Wall -g
