#ifndef POPS_PKTS_H_INCLUDED
#define POPS_PKTS_H_INCLUDED

#include "POPS_int.h"

class POPSpkt : public UserPkt {
  public:
    POPSpkt();
    int Process_Pkt();
  private:
    POPS_t POPS;
};

#endif
