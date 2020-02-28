tmcbase = base.tmc

Module TMbase

TGTDIR = $(PWD)/../..
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services

DPOPSdisp : DPOPS.tbl
DPOPSalgo : DPOPS.tma
madedoit : DPOPS.doit
