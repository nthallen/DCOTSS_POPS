%INTERFACE <Alicat>

%{
  #ifdef SERVER
  void Alicat_set(int ID, float setpoint) {
    uint32_t rawset = *(uint32_t*)&setpoint;
    // WII:FF:AAAA:NN:DD:DD...

    // II is the device ID
    // FF is the Modbus function code
    // AA is the register address
    // NN is the number of registers
    // DD are the register values
    // All values are in hex
    if_Alicat.Turf("W%X:%X:%X:2:%X:%X\n",
      ID, 16, 1009, ((rawset>>16) & 0xFFFF),
      (rawset & 0xFFFF));
  }
  #endif
%}

&command
  : MFC Bypass Flow SetPoint %f (nccm) nccm * { Alicat_set(1, $5); }
  : MFC POPS Flow SetPoint %f (nccm) nccm * { Alicat_set(2, $5); }
  : MFC Moudi Flow SetPoint %f (nccm) nccm * { Alicat_set(3, $5); }
  ;
