&LFE_gain <float>
  : %f (Enter Gain Value) { $0 = $1; }
  ;
&LPFP <uint8_t>
  : %d (Enter filter period in seconds) Seconds { $0 = $1; }
  ;
&SimVel <uint8_t>
  : %d (Enter Simulated Velocity in m/s) m/s { $0 = $1 < 0 ? 0 : $1; }
  ;
&BPPer <uint8_t>
  : %d (Enter PI Loop Period in secs > 0) secs { $0 = $1 < 0 ? 0 : $1; }
  ;
&IsoPct <uint8_t>
  : %d (Enter percent of Isokinetic Flow) { $0 = $1 < 0 ? 0 : $1; }
  ;
