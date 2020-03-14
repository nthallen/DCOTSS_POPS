tmcbase = base.tmc
genuibase = DPOPS.genui
cmdbase = playback.cmd

Module TMbase
Module alicat src=alicat.txt
Module POPS

TGTDIR = /home/DPOPS
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services interact
IDISTRIB = doit

DPOPSdisp : DPOPS.tbl POPS.tbl
DPOPSalgo : DPOPS.tma
madedoit : DPOPS.doit
%%
CXXFLAGS=-Wall -g
