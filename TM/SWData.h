/* SWData.h */
#ifndef SWDATA_H_INCLUDED
#define SWDATA_H_INCLUDED

typedef struct __attribute__((__packed__)) {
  unsigned char SWStat;
  uint16_t InltBPZV;
} SWData_t;
extern SWData_t SWData;

#define SWS_EXPLORE_FLOWS 20
#define SWS_FLOWS_ABORT 21
#define SWS_SHUTDOWN 255

#endif
