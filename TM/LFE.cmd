&LFE_gain <float>
  : %f (Enter Gain Value) { $0 = $1; }
  ;
&LPFP <uint8_t>
  : %d (Enter filter period in seconds) Seconds { $0 = $1; }
  ;
