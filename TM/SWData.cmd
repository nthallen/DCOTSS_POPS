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
  : Shutdown Full { $0 = SWS_SHUTDOWN; }
  : Set %d { $0 = $2; }
  ;
&InltBPZV <uint16_t>
  : %f (volts) volts { $0 = (uint16_t)((($1 < 0) ? 0 : ($1 >= 1) ? 1 : $1) * 10000.); }
  ;
