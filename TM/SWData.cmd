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
  ;
&SWStat <unsigned char>
  : Altitude Takeoff { $0 = SWS_TAKEOFF; }
  : Set %d { $0 = $2; }
  : Altitude Land { $0 = SWS_LAND; }
  : Explore Flows { $0 = SWS_EXPLORE_FLOWS; }
  : Abort Flows { $0 = SWS_FLOWS_ABORT; }
  : Fixed Flow { $0 = SWS_FIXED_FLOWS; }
  : Disable POPS Pump Algo { $0 = SWS_PPUMP_DISABLE; }
  : Disable Bypass Pump Algo { $0 = SWS_BPUMP_DISABLE; }
  : Time Warp { $0 = SWS_TIME_WARP; }
  : Shutdown Full { $0 = SWS_SHUTDOWN; }
  ;
