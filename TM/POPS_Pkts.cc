#include "POPS.h"
#include "POPS_int.h"
#include "POPS_Pkts.h"

POPSpkt::POPSpkt() : UserPkt("POPS") {
  TM_init(&POPS, sizeof(POPS_t));
}

int POPSpkt::Process_Pkt() {
  return (
    not_ISO8601(&POPS.Time, true) || not_str(",", 1) ||
    not_nfloat(&POPS.Part_Num) || not_str(",", 1) ||
    not_nfloat(&POPS.PartCon_num_cc) || not_str(",", 1) ||
    not_nfloat(&POPS.Baseline) || not_str(",", 1) ||
    not_nfloat(&POPS.STD) || not_str(",", 1) ||
    not_nfloat(&POPS.P_mbar) || not_str(",", 1) ||
    not_nfloat(&POPS.Flow) || not_str(",", 1) ||
    not_nfloat(&POPS.LDTemp) || not_str(",", 1) ||
    not_nfloat(&POPS.LD_Mon) || not_str(",", 1) ||
    not_nfloat(&POPS.Temp) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin01) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin02) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin03) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin04) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin05) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin06) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin07) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin08) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin09) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin10) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin11) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin12) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin13) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin14) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin15) || not_str(",", 1) ||
    not_nfloat(&POPS.Bin16)
  );
}

UserPkts::UserPkts(Selector *S) {
  UserPkts_UDP *UP;
  UP = new UserPkts_UDP(7079);
  UP->add_packet(new POPSpkt());
  S->add_child(UP);
  UDPs.push_back(UP);
}

