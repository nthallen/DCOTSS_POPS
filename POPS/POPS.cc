#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <errno.h>

#include "dasio/msg.h"
#include "dasio/quit.h"
#include "dasio/tm_data_sndr.h"
#include "nl.h"
#include "oui.h"
#include "POPS_int.h"

POPS_t POPS;

int main(int argc, char **argv) {
  oui_init_options(argc, argv);
  DAS_IO::Loop ELoop;
  UserPkts_UDP *Pkts = new UserPkts_UDP(7079); // constructor generated
  ELoop.add_child(Pkts);
  DAS_IO::Quit *Q = new DAS_IO::Quit();
  Q->connect();
  ELoop.add_child(Q);
  DAS_IO::TM_data_sndr *TM =
    new DAS_IO::TM_data_sndr("POPS", 0, "POPS", &POPS, sizeof(POPS));
  TM->connect();
  ELoop.add_child(TM);
  msg(0, "Starting: V3.0");
  ELoop.event_loop();
  msg(0, "Terminating");
}

UserPkts_UDP::UserPkts_UDP(int udp_port)
    : DAS_IO::Interface("UDP", 512),
      udp_port(udp_port) {
  Bind(udp_port);
  // flush_input();
  setenv("TZ", "UTC0", 1); // Force UTC for mktime()
}

bool UserPkts_UDP::protocol_input() {
  // double Time;
  uint32_t Part_Num;
  float    PartCon_num_cc;
  uint32_t Baseline;
  float    STD;
  float    P_mbar;
  float    Flow;
  float    LDTemp;
  float    LD_Mon;
  float    Temp;
  uint32_t Bin01;
  uint32_t Bin02;
  uint32_t Bin03;
  uint32_t Bin04;
  uint32_t Bin05;
  uint32_t Bin06;
  uint32_t Bin07;
  uint32_t Bin08;
  uint32_t Bin09;
  uint32_t Bin10;
  uint32_t Bin11;
  uint32_t Bin12;
  uint32_t Bin13;
  uint32_t Bin14;
  uint32_t Bin15;
  uint32_t Bin16;
  int year, month, day, hour, minute, second;
  struct tm buft;
  le_time_t ltime;

  cp = 0;
  if (not_str("POPS,") ||
      not_ndigits(4,year) || not_ndigits(2, month) || not_ndigits(2,day) ||
      not_str("T") || not_ndigits(2,hour) || not_ndigits(2,minute) ||
      not_ndigits(2,second) || not_str(",", 1) ||
      not_uint32(Part_Num) || not_str(",", 1) ||
      not_nfloat(&PartCon_num_cc) || not_str(",", 1) ||
      not_uint32(Baseline) || not_str(",", 1) ||
      not_nfloat(&STD) || not_str(",", 1) ||
      not_nfloat(&P_mbar) || not_str(",", 1) ||
      not_nfloat(&Flow) || not_str(",", 1) ||
      not_nfloat(&LDTemp) || not_str(",", 1) ||
      not_nfloat(&LD_Mon) || not_str(",", 1) ||
      not_nfloat(&Temp) || not_str(",", 1) ||
      not_uint32(Bin01) || not_str(",", 1) ||
      not_uint32(Bin02) || not_str(",", 1) ||
      not_uint32(Bin03) || not_str(",", 1) ||
      not_uint32(Bin04) || not_str(",", 1) ||
      not_uint32(Bin05) || not_str(",", 1) ||
      not_uint32(Bin06) || not_str(",", 1) ||
      not_uint32(Bin07) || not_str(",", 1) ||
      not_uint32(Bin08) || not_str(",", 1) ||
      not_uint32(Bin09) || not_str(",", 1) ||
      not_uint32(Bin10) || not_str(",", 1) ||
      not_uint32(Bin11) || not_str(",", 1) ||
      not_uint32(Bin12) || not_str(",", 1) ||
      not_uint32(Bin13) || not_str(",", 1) ||
      not_uint32(Bin14) || not_str(",", 1) ||
      not_uint32(Bin15) || not_str(",", 1) ||
      not_uint32(Bin16)) {
    if (cp < nc) {
      consume(nc);
    }
    return false;
  }
  buft.tm_year = year - 1900;
  buft.tm_mon = month - 1;
  buft.tm_mday = day;
  buft.tm_hour = hour;
  buft.tm_min = minute;
  buft.tm_sec = second;
  ltime = mktime(&buft);
  if (ltime == (le_time_t)(-1))
    report_err("%s: mktime returned error", iname);
  else POPS.Time = ltime;
  POPS.Part_Num = Part_Num;
  POPS.PartCon_num_cc = PartCon_num_cc;
  POPS.Baseline = Baseline;
  POPS.STD = STD;
  POPS.P_mbar = P_mbar;
  POPS.Flow = Flow;
  POPS.LDTemp = LDTemp;
  POPS.LD_Mon = LD_Mon;
  POPS.Temp = Temp;
  POPS.Bin01 = Bin01;
  POPS.Bin02 = Bin02;
  POPS.Bin03 = Bin03;
  POPS.Bin04 = Bin04;
  POPS.Bin05 = Bin05;
  POPS.Bin06 = Bin06;
  POPS.Bin07 = Bin07;
  POPS.Bin08 = Bin08;
  POPS.Bin09 = Bin09;
  POPS.Bin10 = Bin10;
  POPS.Bin11 = Bin11;
  POPS.Bin12 = Bin12;
  POPS.Bin13 = Bin13;
  POPS.Bin14 = Bin14;
  POPS.Bin15 = Bin15;
  POPS.Bin16 = Bin16;
  report_ok(nc);
  return false;
}

bool UserPkts_UDP::process_eof() {
  msg(0, "%s: process_eof(): Re-binding UDP port %d",
    iname, udp_port);
  Bind(udp_port);
  return false;
}

//  int UserPkts_UDP::not_KW(char *KWbuf) {
//    int KWi = 0;
//    while (cp < nc && isspace(buf[cp]))
//      ++cp;
//    while (cp < nc && KWi < 30 && !isspace(buf[cp]) &&
//           buf[cp] != ',') {
//      KWbuf[KWi++] = buf[cp++];  
//    }
//    if (KWi >= 30) {
//      report_err("Keyword overflow");
//      return 1;
//    } else if (buf[cp] == ',') {
//      KWbuf[KWi] = '\0';
//      ++cp;
//      return 0;
//    } else {
//      report_err("Unexpected char in not_KW");
//      return 1;
//    }
//  }

void UserPkts_UDP::Bind(int port) {
  char service[10];
  struct addrinfo hints,*results, *p;
  int err, ioflags;

  if (port == 0)
    msg( 3, "Invalid port in UserPkts_UDP: 0" );
  snprintf(service, 10, "%d", port);

  memset(&hints, 0, sizeof(hints));	
  hints.ai_family = AF_UNSPEC;		// don't care IPv4 of v6
  hints.ai_socktype = SOCK_DGRAM;
  hints.ai_flags = AI_PASSIVE;
    
  err = getaddrinfo(NULL, 
                    service,
                    &hints,
                    &results);
  if (err)
    msg( 3, "UserPkts_UDP::Bind: getaddrinfo error: %s",
          gai_strerror(err) );
  for(p=results; p!= NULL; p=p->ai_next) {
    fd = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
    if (fd < 0)
      msg( 2, "IWG1_UPD::Bind: socket error: %s", strerror(errno) );
    else if ( bind(fd, p->ai_addr, p->ai_addrlen) < 0 )
      msg( 2, "UserPkts_UDP::Bind: bind error: %s", strerror(errno) );
    else break;
  }
  if (fd < 0)
    msg(3, "Unable to bind UDP socket");
    
  ioflags = fcntl(fd, F_GETFL, 0);
  if (ioflags != -1)
    ioflags = fcntl(fd, F_SETFL, ioflags | O_NONBLOCK);
  if (ioflags == -1)
    msg( 3, "Error setting O_NONBLOCK on UDP socket: %s",
      strerror(errno));
  flags = DAS_IO::Interface::Fl_Read;
}

//  int UserPkts_UDP::fillbuf() {
//    struct sockaddr_storage from;
//    socklen_t fromlen = sizeof(from);
//    int rv = recvfrom(fd, &buf[nc], bufsize - nc - 1, 0,
//                (struct sockaddr*)&from, &fromlen);
//  	
//    if (rv == -1) {
//      if ( errno == EWOULDBLOCK ) {
//        ++n_eagain;
//      } else if (errno == EINTR) {
//        ++n_eintr;
//      } else {
//        msg( 2, "%s: UserPkts_UDP::fillbuf: recvfrom error: %s",
//                  iname, strerror(errno));
//        return 1;
//      }
//      return 0;
//    }
//    nc += rv;
//    buf[nc] = '\0';
//    return 0;
//  }