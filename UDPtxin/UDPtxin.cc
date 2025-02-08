#include <netdb.h>
#include <arpa/inet.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include "dasio/loop.h"
#include "UDP_address.h"
#include "UDPtxin_int.h"
#include "UDPtxin.h"
#include "oui.h"
#include "nl.h"

using namespace DAS_IO;

bool UDPext_debug;
UDPtxin_t UDPtxin;

int main(int argc, char **argv) {
  oui_init_options(argc, argv);
  Loop ELoop;
  msg(0, "Transmitting commands to %s:%s",
    CMD_TRANSMIT_IP, CMD_TRANSMIT_PORT);
  CR_UDPtx *CRxUtx =
    new CR_UDPtx(CMD_TRANSMIT_IP, CMD_TRANSMIT_PORT);
    // This is the IP to send commands to the instrument
    // Instrument will receive via broadcast, but broadcasting
    // doesn't work well when we are trying to receive on the
    // same port number, so go with fixed IP.

  CRxUtx->connect();
  ELoop.add_child(CRxUtx);
  
  TM_data_sndr *tm =
      new TM_data_sndr("TM", 0, "UDPtxin", &UDPtxin, sizeof(UDPtxin_t));
  ELoop.add_child(tm);
  tm->connect();

  msg(0, "Listening for UDP data on port %s", TM_BROADCAST_PORT);
  UDPrx_TM *UrxTM = new UDPrx_TM(tm, TM_BROADCAST_PORT);
  ELoop.add_child(UrxTM);
  
  msg(0, "Started");
  ELoop.event_loop();
  ELoop.delete_children();
  ELoop.clear_delete_queue(true);
  msg(MSG, "Terminating");
  return 0;
}

/**
 * The Cmd_reader Command channel "UDPCmdTx" is specified in
 * TM/DPOPS.cmd.
 */
CR_UDPtx::CR_UDPtx(const char *broadcast_ip, const char *broadcast_port)
    : Cmd_reader("UDPtx", 200, "UDPCmdTx") {
  UDPtx = new UDPbcast(broadcast_ip, broadcast_port);
}

CR_UDPtx::~CR_UDPtx() {
  if (UDPtx) {
    delete(UDPtx);
    UDPtx = 0;
  }
}

/**
 * Receives commands from txsrvr and forwards them to a UDP address
 */
bool CR_UDPtx::app_input() {
  if (nc >= 1 && buf[0] == 'Q' && buf[1] == '\n') {
    return true;
  }
  msg(0, "Relaying: %s", buf);
  UDPtx->Broadcast("%s", buf);
  report_ok(nc);
  return false;
}

UDPrx_TM::UDPrx_TM(TM_data_sndr *tm, const char *port)
    : Interface("UDP", 600 ),
      tm(tm) {
  // Set up UDP listener
  Bind(port);
  flags = Fl_Read;
  // flush_input();
  setenv("TZ", "UTC0", 1); // Force UTC for mktime()
}

bool UDPrx_TM::protocol_input() {
  if (not_str( "DPOPS," ) ||
      not_ISO8601(UDPtxin.Time) || not_str( ",", 1) ||

      not_uint8(UDPtxin.InstS) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.POPS_num_cc) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.POPS_Surf_Area) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.POPS_ccm) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.POPS_Temp) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.POPS_P_mbar) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.HPS_P) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.MS5607_P) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.Amb_T) || not_str(",", 1) ||
      not_nfloat(&UDPtxin.PPmpT)) {
    if (cp < nc) {
      consume(nc); // syntax error (already reported). Empty
    } // else cp == nc, so it was a partial record. See if we will get more.
    return 0;
  }
  tm->Send();
  report_ok(nc);
  return 0;
}

void UDPrx_TM::Bind(const char *port) {
	struct addrinfo hints,*results, *p;
  int err, ioflags;

	if (port == 0)
    msg(MSG_FATAL, "Invalid port in UDPrx_TM: 0" );

	memset(&hints, 0, sizeof(hints));	
	hints.ai_family = AF_INET;		// IPv4
	hints.ai_socktype = SOCK_DGRAM;
	hints.ai_flags = AI_PASSIVE;
	
	err = getaddrinfo(NULL, 
						port,
						&hints,
						&results);
	if (err)
    msg(MSG_FATAL, "UDPrx_TM::Bind: getaddrinfo error: %s", gai_strerror(err) );
	for(p=results; p!= NULL; p=p->ai_next) {
		fd = socket(p->ai_family, p->ai_socktype, p->ai_protocol);
		if (fd < 0)
      msg(MSG_ERROR, "UDPrx_TM::Bind: socket error: %s", strerror(errno) );
		else if ( bind(fd, p->ai_addr, p->ai_addrlen) < 0 )
      msg(MSG_ERROR, "UDPrx_TM::Bind: bind error: %s", strerror(errno) );
		else break;
	}
  if (fd < 0)
    msg(MSG_FATAL, "Unable to bind UDP socket");
    
  ioflags = fcntl(fd, F_GETFL, 0);
  if (ioflags != -1)
    ioflags = fcntl(fd, F_SETFL, ioflags | O_NONBLOCK);
  if (ioflags == -1)
    msg(MSG_FATAL, "Error setting O_NONBLOCK on UDP socket: %s",
      strerror(errno));
}

int UDPrx_TM::fillbuf() {
	struct sockaddr_storage from;
	socklen_t fromlen = sizeof(from);
	int rv = recvfrom(fd, &buf[nc],	bufsize - nc - 1, 0,
						(struct sockaddr*)&from, &fromlen);
	
	if (rv == -1) {
    if ( errno == EWOULDBLOCK ) {
      ++n_eagain;
    } else if (errno == EINTR) {
      ++n_eintr;
    } else {
      msg(MSG_ERROR, "UDPrx_TM::fillbuf: recvfrom error: %s", strerror(errno));
      return 1;
    }
    return 0;
  }
  nc += rv;
  buf[nc] = '\0';
  return 0;
}
