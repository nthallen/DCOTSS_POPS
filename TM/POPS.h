#ifndef POPS_H_INCLUDED
#define POPS_H_INCLUDED

#include <time.h>

typedef struct __attribute__((__packed__)) {
  double Time;
  float Part_Num;
  float PartCon_num_cc;
  float Baseline;
  float STD;
  float P_mbar;
  float Flow;
  float LDTemp;
  float LD_Mon;
  float Temp;
  float Bin01;
  float Bin02;
  float Bin03;
  float Bin04;
  float Bin05;
  float Bin06;
  float Bin07;
  float Bin08;
  float Bin09;
  float Bin10;
  float Bin11;
  float Bin12;
  float Bin13;
  float Bin14;
  float Bin15;
  float Bin16;
} POPS_t;
extern POPS_t POPS;

#endif
