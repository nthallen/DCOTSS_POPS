%INTERFACE <Alicat>

%{
  #ifdef SERVER
  int Alicat_control_var[3]; // initialized to zero, MF
  
  void Alicat_set(int ID, float setpoint, int units) {
    uint32_t rawset = *(uint32_t*)&setpoint;
    if (ID < 1 || ID > 3) {
      msg(MSG_ERROR, "Invalid device ID: %d", ID);
      return;
    }
    if (units != Alicat_control_var[ID-1]) {
      msg(MSG_ERROR,
        "Command units do not match currently selected control var");
      return;
    }
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
  
  void Alicat_control(int ID, int ctrl_var_id) {
    // ctrl_var_id is on of:
    //  0: Mass Flow
    //  1: Volumetric Flow
    //  2: Diff Pressure
    //  3: Absolute Pressure
    //  4: Gauge Pressure

    // WII:FF:AAAA:NN:DD:DD...
    // II is the device ID
    // FF is the Modbus function code
    // AA is the register address
    // NN is the number of registers
    // DD are the register values
    // All values are in hex
    if (ID < 1 || ID > 3) {
      msg(MSG_ERROR, "Invalid device ID: %d", ID);
      return;
    }
    
    if_Alicat.Turf("W%X:%X:%X:2:%X:%X\n",
      ID, 16, 1000, 11, ctrl_var_id);
    Alicat_control_var[ID-1] = ctrl_var_id; 
  }
  #endif
%}

&command
  : MFC Bypass Flow SetPoint %f &BMFC_ctrl * { Alicat_set(1, $5, $6); }
  : MFC Bypass Set Control Loop Variable to &BMFC_ctrl * { Alicat_control(1, $8); }
  : MFC POPS Flow SetPoint %f &PMFC_ctrl * { Alicat_set(2, $5, $6); }
  : MFC POPS Set Control Loop Variable to &PMFC_ctrl * { Alicat_control(2, $8); }
  : MFC Moudi Flow SetPoint %f &MMFC_ctrl * { Alicat_set(3, $5, $6); }
  : MFC Moudi Set Control Loop Variable to &MMFC_ctrl * { Alicat_control(3, $8); }
  ;

&BMFC_ctrl <int>
  : nccm { $0 = 0; }
  : ccm { $0 = 1; }
  ;

&PMFC_ctrl <int>
  : nccm { $0 = 0; }
  : ccm { $0 = 1; }
  ;

&MMFC_ctrl <int>
  : nccm { $0 = 0; }
  : ccm { $0 = 1; }
  ;

