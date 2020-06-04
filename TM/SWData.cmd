%{
  #include "SWData.h"
  #ifdef SERVER
    SWData_t SWData;
  #endif
%}

%INTERFACE <SWData:DG/data>

&command
  : &SWTM * { if_SWData.Turf(); }
  ;
&SWTM
  : SW Status &SWStat { SWData.SWStat = $3; }
  : Baratron Zero &InltBPZV { SWData.InltBPZV = $3; }
  ;
&SWStat <unsigned char>
  : Explore Flows { $0 = SWS_EXPLORE_FLOWS; }
  : Set %d { $0 = $2; }
  : Abort Flows { $0 = SWS_FLOWS_ABORT; }
  : Fixed Flow { $0 = SWS_FIXED_FLOWS; }
  : Shutdown Full { $0 = SWS_SHUTDOWN; }
  ;
&InltBPZV <uint16_t>
  : %f (volts) volts { $0 = (uint16_t)((($1 < 0) ? 0 : ($1 >= 1) ? 1 : $1) * 10000.); }
  ;
