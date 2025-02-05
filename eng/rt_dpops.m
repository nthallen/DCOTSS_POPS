function dfs_out = rt_dpops(dfs)
% dfs = rt_dpops()
%   Create a data_fields object and setup all the buttons for realtime
%   plots
% dfs_out = rt_dpops(dfs)
%   Use the data_fields object and setup all the buttons for realtime plots
if nargin < 1 || isempty(dfs)
  dfs = data_fields('title', 'DCOTSS POPS', ...
    'Color', [.8 .8 1], ...
    'h_leading', 8, 'v_leading', 2, ...
    'btn_fontsize', 12, ...
    'txt_fontsize', 12);
  context_level = dfs.rt_init;
else
  context_level = 1;
end
dfs.start_col;
dfs.plot('a', 'label', 'Algo', 'plots', {'asws','ag','af','amf','alp','aip','asa'});
dfs.plot('asws','label','SW Stat','vars',{'SWStat'});
dfs.plot('ag','label','Gains','vars',{'LFE_PGain','LFE_IGain','BPmp_PGain','BPmp_IGain'});
dfs.plot('af','label','Filter','vars',{'BPmp_IGain'});
dfs.plot('amf','label','M Ffilt','vars',{'BMFC_MassFlow','BMFC_MF_LP'});
dfs.plot('alp','label','L Pper','vars',{'BPmp_LPFP'});
dfs.plot('aip','label','Iso Pct','vars',{'IsoKin_pct'});
dfs.plot('asa','label','Sim Alt','vars',{'Sim_Alt'});
dfs.plot('dacsa', 'label', 'uDACS A', 'plots', {'dacsas','dacsaais','dacsat','dacsaain'});
dfs.plot('dacsas','label','Status','vars',{{'name','Fail','var_name','FailMode','bit_number',0},{'name','Mode','var_name','FailMode','bit_number',4}});
dfs.plot('dacsaais','label','AI Stat','vars',{'uDACS_A_status'});
dfs.plot('dacsat','label','Temps','vars',{'POPST','RPi_T','Amb_T','Rov1T','Rov2T','Rov3T'});
dfs.plot('dacsaain','label','AI N','vars',{'uDACS_A_N'});
dfs.plot('ms', 'label', 'MS5607', 'plots', {'msp','mst'});
dfs.plot('msp','label','P','vars',{'MS5607_P'});
dfs.plot('mst','label','T','vars',{'MS5607_T'});
dfs.plot('p', 'label', 'Pumps', 'plots', {'pt','ps','pbpv'});
dfs.plot('pt','label','Temps','vars',{'PPmpT','BPmpT'});
dfs.plot('ps','label','Status','vars',{{'name','PPmpCmd','var_name','PumpsStat','bit_number',0},{'name','PPmpS','var_name','PumpsStat','bit_number',1},{'name','BPmpCmd','var_name','PumpsStat','bit_number',2},{'name','BPmpS','var_name','PumpsStat','bit_number',3}});
dfs.plot('pbpv','label','B Pmp V','vars',{'BPmpV'});
dfs.end_col;
dfs.start_col;
dfs.plot('pops', 'label', 'POPS', 'plots', {'popss','popsd','popspn','popsnum_cc','popssurface','popsv','popsp','popsf','popsr','popst','popsb'});
dfs.plot('popss','label','Status','vars',{{'name','POPSPwr','var_name','PwrStat','bit_number',3}});
dfs.plot('popsd','label','Drift','vars',{'POPS_Tdrift'});
dfs.plot('popspn','label','Part Num','vars',{'POPS_Part_Num'});
dfs.plot('popsnum_cc','label','num cc','vars',{'POPS_num_cc'});
dfs.plot('popssurface','label','Surface','vars',{'POPS_Surf_Area'});
dfs.plot('popsv','label','Volume','vars',{'POPS_Vol_Density'});
dfs.plot('popsp','label','P','vars',{'POPS_P_mbar'});
dfs.plot('popsf','label','Flow','vars',{'POPS_ccm'});
dfs.plot('popsr','label','Raw ccs','vars',{'POPS_Flow'});
dfs.plot('popst','label','T','vars',{'POPS_Temp'});
dfs.plot('popsb','label','Bins','vars',{'POPS_Bin01','POPS_Bin02','POPS_Bin03','POPS_Bin04','POPS_Bin05','POPS_Bin06','POPS_Bin07','POPS_Bin08','POPS_Bin09','POPS_Bin10','POPS_Bin11','POPS_Bin12','POPS_Bin13','POPS_Bin14','POPS_Bin15','POPS_Bin16'});
dfs.plot('m', 'label', 'Moudi', 'plots', {'mc','mstatus'});
dfs.plot('mc','label','Command','vars',{'MMcmd'});
dfs.plot('mstatus','label','Status','vars',{'MMstat'});
dfs.end_col;
dfs.start_col;
dfs.plot('dacsb', 'label', 'uDACS B', 'plots', {'dacsbais','dacsbaics','dacsbain','dacsbai','dacsbr'});
dfs.plot('dacsbais','label','AI Stat','vars',{'uDACS_B_status'});
dfs.plot('dacsbaics','label','AI Ch S','vars',{{'name','MSat1','var_name','uDACS_B_stat1','bit_number',2},{'name','FSat1','var_name','uDACS_B_stat1','bit_number',1},{'name','OUV1','var_name','uDACS_B_stat1','bit_number',0},{'name','MSat2','var_name','uDACS_B_stat2','bit_number',2},{'name','FSat2','var_name','uDACS_B_stat2','bit_number',1},{'name','OUV2','var_name','uDACS_B_stat2','bit_number',0},{'name','MSat3','var_name','uDACS_B_stat3','bit_number',2},{'name','FSat3','var_name','uDACS_B_stat3','bit_number',1},{'name','OUV3','var_name','uDACS_B_stat3','bit_number',0}});
dfs.plot('dacsbain','label','AI N','vars',{'uDACS_B_N'});
dfs.plot('dacsbai','label','AI errs','vars',{'uDACS_B_errors'});
dfs.plot('dacsbr','label','Raw','vars',{'uDACS_B_Raw1','uDACS_B_Raw2','uDACS_B_Raw3'});
dfs.plot('i', 'label', 'Inlet', 'plots', {'irt','iv','inccm'});
dfs.plot('irt','label','Ring T','vars',{'Ring1T','Ring2T','Ring3T','RingT'});
dfs.plot('iv','label','Velocity','vars',{'PD_Vel'});
dfs.plot('inccm','label','NCCM','vars',{'PD_nccm'});
dfs.plot('h', 'label', 'Honeywell', 'plots', {'hs','hhpst','hhpsp','hhps_dp'});
dfs.plot('hs','label','Status','vars',{{'name','PS1_Init','var_name','HPS_Stat','bit_number',0},{'name','PS1_CRC_OK','var_name','HPS_Stat','bit_number',1},{'name','PS2_Init','var_name','HPS_Stat','bit_number',2},{'name','PS2_CRC_OK','var_name','HPS_Stat','bit_number',3},{'name','PS3_Init','var_name','HPS_Stat','bit_number',4},{'name','PS3_CRC_OK','var_name','HPS_Stat','bit_number',5}});
dfs.plot('hhpst','label','HPS T','vars',{'HPS1_Temp','HPS2_Temp','HPS3_Temp'});
dfs.plot('hhpsp','label','HPS P','vars',{'HPS_P','HPS3_P'});
dfs.plot('hhps_dp','label','HPS dP','vars',{'HPS_dP'});
dfs.plot('tm', 'label', 'T Mbase', 'plots', {'tmtd','tmcpu','tmram','tmd'});
dfs.plot('tmtd','label','T Drift','vars',{'SysTDrift'});
dfs.plot('tmcpu','label','CPU','vars',{'CPU_Pct'});
dfs.plot('tmram','label','RAM','vars',{'memused'});
dfs.plot('tmd','label','Disk','vars',{'Disk'});
dfs.end_col;
dfs.start_col;
dfs.plot('ahk', 'label', 'Alicat HK', 'plots', {'ahks','ahkstale','ahkmbar','ahkt'});
dfs.plot('ahks','label','Status','vars',{'BMFC_Status','PMFC_Status','MMFC_Status'});
dfs.plot('ahkstale','label','Stale','vars',{'BMFC_Stale','PMFC_Stale','MMFC_Stale','Alicat_Stale'});
dfs.plot('ahkmbar','label','mbar','vars',{'BMFC_P','PMFC_P','MMFC_P'});
dfs.plot('ahkt','label','T','vars',{'BMFC_T','PMFC_T','MMFC_T'});
dfs.plot('alicat', 'label', 'Alicat', 'plots', {'alicatnccm','alicatccm'});
dfs.plot('alicatnccm','label','nccm','vars',{'BMFC_MassFlow','BMFC_Set','PMFC_MassFlow','PMFC_Set','MMFC_MassFlow','MMFC_Set'});
dfs.plot('alicatccm','label','ccm','vars',{'BMFC_VolFlow','PMFC_VolFlow','MMFC_VolFlow'});
dfs.plot('popshk', 'label', 'POPS HK', 'plots', {'popshkstd','popshkldt','popshkldm','popshkb','popshks','popshkstale'});
dfs.plot('popshkstd','label','STD','vars',{'POPS_STD'});
dfs.plot('popshkldt','label','LD Temp','vars',{'POPS_LDTemp'});
dfs.plot('popshkldm','label','LD Mon','vars',{'POPS_LD_Mon'});
dfs.plot('popshkb','label','Baseline','vars',{'POPS_Baseline'});
dfs.plot('popshks','label','Srvr','vars',{'POPS_Srvr'});
dfs.plot('popshkstale','label','Stale','vars',{'POPS_Stale','POPS_DrvStale'});
dfs.end_col;
dfs.start_col;
dfs.plot('iwg', 'label', 'IWG1', 'plots', {'iwgl','iwglon','iwgt','iwgp','iwgs','iwgm','iwga'});
dfs.plot('iwgl','label','Lat','vars',{'Lat'});
dfs.plot('iwglon','label','Lon','vars',{'Lon'});
dfs.plot('iwgt','label','Temp','vars',{'Ambient_Temp','Total_Temp','Dew_Point'});
dfs.plot('iwgp','label','Pres','vars',{'Dynamic_Press','Static_Press'});
dfs.plot('iwgs','label','Speed','vars',{'Grnd_Spd','Indicated_Airspeed','True_Airspeed'});
dfs.plot('iwgm','label','Mach','vars',{'Mach_Number'});
dfs.plot('iwga','label','Alt','vars',{'GPS_MSL_Alt','Press_Alt','Radar_Alt','WGS_84_Alt'});
dfs.plot('attitude', 'label', 'Attitude', 'plots', {'attitudea','attitudep','attituder','attitudess','attituded','attitudesz','attitudeaz','attitude_az','attitudet'});
dfs.plot('attitudea','label','Attack','vars',{'Angle_of_Attack'});
dfs.plot('attitudep','label','Pitch','vars',{'Pitch'});
dfs.plot('attituder','label','Roll','vars',{'Roll'});
dfs.plot('attitudess','label','Side Slip','vars',{'Side_slip'});
dfs.plot('attituded','label','Drift','vars',{'Drift'});
dfs.plot('attitudesz','label','SZ','vars',{'Solar_Zenith','Sun_Elev_AC'});
dfs.plot('attitudeaz','label','AZ','vars',{'Sun_Az_AC'});
dfs.plot('attitude_az','label','Az','vars',{'Sun_Az_Grd'});
dfs.plot('attitudet','label','Track','vars',{'Track','True_Hdg'});
dfs.end_col;
dfs.start_col;
dfs.plot('w', 'label', 'Wind', 'plots', {'wvv','wvs','wd','ws'});
dfs.plot('wvv','label','Vert Vel','vars',{'Vert_Velocity'});
dfs.plot('wvs','label','Vert Speed','vars',{'Vert_Wind_Spd'});
dfs.plot('wd','label','Dir','vars',{'Wind_Dir'});
dfs.plot('ws','label','Speed','vars',{'Wind_Speed'});
dfs.plot('iwg1_stat', 'label', 'IWG1 Stat', 'plots', {'iwg1_statcp','iwg1_stattd','iwg1_stats'});
dfs.plot('iwg1_statcp','label','Cabin Press','vars',{'Cabin_Press'});
dfs.plot('iwg1_stattd','label','T Drift','vars',{'TDDrift','TDrift'});
dfs.plot('iwg1_stats','label','Stale','vars',{'IWG1_Stale'});
dfs.end_col;
dfs.set_connection('127.0.0.1', 1356);
if nargout > 0
  dfs_out = dfs;
else
  dfs.resize(context_level);
end
