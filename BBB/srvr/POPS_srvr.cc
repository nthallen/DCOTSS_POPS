/**
POPS_Server
  Listen on TCP port 7079 (if possible: apparently so, but could check during operation)
  On accept, send current status
  Loop on read() supporting:
    V: Status : Respond with current status
    B: Start : Runs POPS_startup script system("/root/SW/bin/start_POPS");
               Status is updated to Active
    E: Shutdown : Runs system("/sbin/shutdown -h now");
                Status is updated to shutdown
                Reply before shutting down
    D: Disconnect : Don't respond, wait for connection to break
    
    Status is reported as an integer
    Error returns are preceded with "Error"
 */
#include "POPS_srvr.h"
#include "dasio/msg.h"

POPS_status_t POPS_status = POPS_idle;

bool pops_socket::protocol_input() {
  cp = 0;
  if (nc == 0) return false;
  unsigned char cmd = buf[0];
  switch (buf[0]) {
    case 'V': // Status
      msg(0, "V request");
      break;
    case 'B':
      msg(0, "Starting POPS software");
      system("/root/SW/bin/start_POPS");
      POPS_status = POPS_active;
      break;
    case 'E':
      if (POPS_status == POPS_active) {
        msg(MSG_ERROR, "Shutdown refused while POPS is active");
        iwrite("Error: Shutdown should be directed to POPS while active\n");
        consume(nc);
        return false;
      }
      msg(0, "Issuing Shutdown");
      POPS_status = POPS_shutdown;
      system("/sbin/shutdown -h now");
      break;
    case 'D':
      msg(0, "Received disconnect message");
      consume(nc);
      return false;
    default:
      if (isgraph(cmd)) {
        msg(MSG_ERROR, "Invalid command code: '%c'", cmd);
      } else {
        msg(MSG_ERROR, "Invalid command value: '0x%02X'", cmd);
      }
      iwrite("Error: Invalid command\n");
      break;
  }
  consume(nc);
  return send_status();
}

bool pops_socket::send_status() {
  char buf[8];
  snprintf(buf, 8, "%d\n", POPS_status);
  if (iwrite(buf) || !obuf_empty()) return true;
  return false;
}

pops_socket *new_pops_socket(Authenticator *Auth, SubService *SS) {
  SS = SS;
  pops_socket *pops = new pops_socket(Auth, Auth->get_iname());
  return pops;
}

int main(int argc, char **argv) {
  oui_init_options(argc, argv);
  Server server("pops");
  server.add_subservice(new SubService("pops",
      (socket_clone_t)new_pops_socket, (void*)0));
  msg(0, "Starting");
  server.Start(Server::Srv_TCP);
  msg(0, "Terminating");
  return 0;
}
