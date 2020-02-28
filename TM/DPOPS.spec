tmcbase = base.tmc

Module TMbase
Module alicat src=alicat.txt
Module UserPkts3 src=POPS_UDP_7079.txt name=POPS

TGTDIR = /home/DPOPS
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services

DPOPSdisp : DPOPS.tbl
DPOPSalgo : DPOPS.tma
madedoit : DPOPS.doit
