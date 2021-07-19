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
  : Set Bypass Pump PGain &BPmp_PGain { SWData.BPmp_PGain = $5; }
  : Set Bypass Pump IGain &BPmp_IGain { SWData.BPmp_IGain = $5; }
  : Set Bypass Pump Filter Period &BPmp_LPFP { SWData.BPmp_LPFP = $6; }
  : Set Simulated Velocity &Sim_Vel { SWData.Sim_Vel = $4; }
  : set Bypass Pump PI Period &BPmp_Per { SWData.BPmp_Per = $6; }
  ;
&SWStat <unsigned char>
  : Altitude Takeoff { $0 = SWS_TAKEOFF; }
  : Set %d { $0 = $2; }
  : Altitude Land { $0 = SWS_LAND; }
  : POPS Power Up Only { $0 = SWS_POPS_POWER_ON; }
  : POPS Startup { $0 = SWS_POPS_STARTUP; }
  : POPS Shutdown { $0 = SWS_POPS_SHUTDOWN; }
  : POPS Flow PI { $0 = SWS_POPS_FLOW_PI; }
  : POPS Flow Quick PI { $0 = SWS_POPS_FLOW_QPI; }
  : POPS Flow Stop { $0 = SWS_POPS_FLOW_STOP; }
  : Bypass Flow Stop { $0 = SWS_BYPASS_FLOW_STOP; }
  : Bypass Flow Isokinetic { $0 = SWS_BYPASS_FLOW_ISO; }
  : Time Warp { $0 = SWS_TIME_WARP; }
  : Shutdown Full { $0 = SWS_SHUTDOWN; }
  ;
&LFE_PGain <float>
  : &LFE_gain { $0 = $1; }
  ;
&LFE_IGain <float>
  : &LFE_gain { $0 = $1; }
  ;
&BPmp_PGain <float>
  : &LFE_gain { $0 = $1; }
  ;
&BPmp_IGain <float>
  : &LFE_gain { $0 = $1; }
  ;
&BPmp_LPFP <uint8_t>
  : &LPFP { $0 = $1; }
  ;
&Sim_Vel <uint8_t>
  : &SimVel { $0 = $1; }
  ;
&BPmp_Per <uint8_t>
  : &BPPer { $0 = $1; }
  ;
