%{
  #ifdef SERVER
  #include "subbuspp.h"
  #include "uDACS_cmd.h"

  subbuspp *uDA;
  bool uDACS_A_present = false;
  
  void uDACS_fail(bool on) {
    if (uDACS_A_present) {
      uDA->write_ack(0x6, on);
    }
  }
  
  void uDACS_init() {
    msg(0, "uDACS_init()");
    uDA = new subbuspp("uDACS_A", "serusb");
    msg(0, "uDA->load()");
    int subfunc = uDA->load();
    if (subfunc == 0) {
      msg(2, "subbus load() failed");
    } else {
      uDACS_A_present = true;
      if (subfunc != 9 && subfunc != 14)
        msg(2, "Expected Subfunction 9 or 14 for uDACS, was %d", subfunc);
    }
  }
  #endif
%}

&command
  : Fail Light &fail_on_off * { uDACS_fail($3); }
  ;
&fail_on_off <bool>
  : on { $0 = true; }
  : off { $0 = false; }
  ;

