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
  : Set LFE PGain &LFE_PGain { SWData.LFE_PGain = $4; }
  : Set LFE IGain &LFE_IGain { SWData.LFE_IGain = $4; }
  ;
&SWStat <unsigned char>
  : Altitude Takeoff { $0 = SWS_TAKEOFF; }
  : Set %d { $0 = $2; }
  : Altitude Land { $0 = SWS_LAND; }
  : POPS Startup { $0 = SWS_POPS_STARTUP; }
  : POPS Shutdown { $0 = SWS_POPS_SHUTDOWN; }
  : POPS Flow Stop { $0 = SWS_POPS_FLOW_STOP; }
  : Bypass Flow Stop { $0 = SWS_BYPASS_FLOW_STOP; }
  : Time Warp { $0 = SWS_TIME_WARP; }
  : Shutdown Full { $0 = SWS_SHUTDOWN; }
  ;
&LFE_PGain <float>
  : &LFE_gain { $0 = $1; }
  ;
&LFE_IGain <float>
  : &LFE_gain { $0 = $1; }
  ;
