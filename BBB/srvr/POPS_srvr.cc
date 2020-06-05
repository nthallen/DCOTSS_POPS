/**
POPS_Server
  Listen on TCP port 7079 (if possible: apparently so, but could check during operation)
  On accept, send current status
  Loop on read() supporting:
    V: Status : Respond with current status
    B: Start : Runs POPS_startup script system("/root/SW/bin/start_POPS");
               Status is updated to Active
    Q: Shutdown : Runs system("/sbin/shutdown -h now");
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
  consume(nc);
  switch (buf[0]) {
    case 'V': break; // Status
    case 'B':
      system("/root/SW/bin/start_POPS");
      POPS_status = POPS_active;
      break;
    case 'Q':
      POPS_status = POPS_shutdown;
      system("/sbin/shutdown -h now");
      break;
    case 'D': return false;
    default:
      if (isgraph(cmd)) {
        msg(MSG_ERROR, "Invalid command code: '%c'", cmd);
      } else {
        msg(MSG_ERROR, "Invalid command value: '0x%02X'", cmd);
      }
      iwrite("Error: Invalid command\n");
      return false;
  }
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
