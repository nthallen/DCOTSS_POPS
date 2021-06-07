/* SWData.h */
#ifndef SWDATA_H_INCLUDED
#define SWDATA_H_INCLUDED

typedef struct __attribute__((__packed__)) {
  unsigned char SWStat;
  float LFE_PGain;
  float LFE_IGain;
  float BPmp_PGain;
  float BPmp_IGain;
  uint8_t BPmp_LPFP;
  uint8_t Sim_Vel;
} SWData_t;
extern SWData_t SWData;

#define SWS_TAKEOFF 1
#define SWS_LAND 4
#define SWS_POPS_STARTUP 30
#define SWS_POPS_SHUTDOWN 31
#define SWS_POPS_FLOW_PI 34
#define SWS_POPS_FLOW_QPI 26
#define SWS_POPS_FLOW_STOP 32
#define SWS_BYPASS_FLOW_STOP 33
#define SWS_BYPASS_FLOW_ISO 35
#define SWS_TIME_WARP 253
#define SWS_SHUTDOWN 255

#endif
