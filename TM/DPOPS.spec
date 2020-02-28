tmcbase = base.tmc

Module TMbase
Module alicat src=alicat.txt

TGTDIR = /home/DPOPS
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services

DPOPSdisp : DPOPS.tbl
DPOPSalgo : DPOPS.tma
madedoit : DPOPS.doit
