#ifndef UDPTXIN_H_INCLUDED
#define UDPTXIN_H_INCLUDED

// This has been rearranged to work without packing
typedef struct {
  double Time;
  float POPS_num_cc;
  float POPS_Surf_Area;
  float POPS_ccm;
  float POPS_Temp;
  float POPS_P_mbar;
  float HPS_P;
  float MS5607_P;
  float Amb_T;
  float PPmpT;
  uint8_t InstS;
} UDPtxin_t;

extern UDPtxin_t UDPtxin;

#endif

