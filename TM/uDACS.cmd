%{
  #ifdef SERVER
  #include "subbuspp.h"
  #include "uDACS_cmd.h"

  subbuspp *uDA;
  subbuspp *uDB;
  bool uDACS_A_present = false;
  bool uDACS_B_present = false;
  
  void uDACS_fail(bool on) {
    if (uDACS_A_present) {
      uDA->write_ack(0x6, on);
    }
  }

  void uDACS_B_cmd(uint16_t cmd) {
    if (uDACS_B_present) {
      uDB->write_ack(0x30, cmd);
    }
  }
  
  /**
   * @param A true for uDACS A, false for uDACS B
   */
  void uDACS_init(bool A) {
    char which = A ? 'A' : 'B';
    msg(0, "uDACS_init(%c)", which);
    subbuspp *uD;
    uD = new subbuspp(A ? "uDACS_A" : "uDACS_B", "serusb");
    msg(0, "uD%c->load()", which);
    int subfunc = uD->load();
    if (subfunc == 0) {
      msg(2, "subbus load() failed");
    } else {
      if (subfunc != 9 && subfunc != 14)
        msg(2, "Expected Subfunction 9 or 14 for uDACS, was %d", subfunc);
      if (A) {
        uDACS_A_present = true;
        uDA = uD;
      } else {
        uDACS_B_present = true;
        uDB = uD;
      }
    }
  }
  #endif
%}

&command
  : Fail Light &fail_on_off * { uDACS_fail($3); }
  : Pump Both &pumps_on_off * { uDACS_B_cmd($3); }
  : Pump POPS &pumps_on_off * { uDACS_B_cmd(2+$3); }
  : Pump Bypass &pumps_on_off * { uDACS_B_cmd(4+$3); }
  ;
&fail_on_off <bool>
  : on { $0 = true; }
  : off { $0 = false; }
  ;
&pumps_on_off <uint16_t>
  : on { $0 = 1; }
  : off { $0 = 0; }
  ;

