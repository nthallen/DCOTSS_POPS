tmcbase = PGS.tmc
genuibase = PGS.genui

Module TMbase mode=ignore
Module UDPtxin

TGTDIR = /home/DPOPS/PGS
IGNORE = "*.o" "*.exe" "*.stackdump" Makefile
DISTRIB = services interact
DISTRIB = ../TM/DPOPStxsrvr ../TM/DPOPScltnc

PGSdisp : PGS.tbl
PGSjsonext : $extbase $genuibase
doit : PGS.doit

%%
# This matches the current definitions in monarch dasio
# and is necessary to see addrinfo/getaddrinfo needed for
# UDP.
CXXFLAGS=-Wall -g -D_POSIX_C_SOURCE=200809L
