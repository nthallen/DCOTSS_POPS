#ifndef UDP_ADDRESS_H_INCLUDED
#define UDP_ADDRESS_H_INCLUDED

/* To compile for test configuration:
     $ make clean-dist
     $ make all-dist CL_CPPFLAGS=-DTEST_SABRE_HOUSTON
   To switch back to flight configuration:
     $ make clean-dist
     $ make all-dist
*/

#if defined(TEST_SABRE_HOUSTON)
  #define TM_BROADCAST_IP "10.11.96.136"
  #define TM_BROADCAST_PORT "7072"
  #define CMD_TRANSMIT_IP "10.11.96.135"
  #define CMD_TRANSMIT_PORT "9090"
#elif defined(TEST_LOCALHOST)
  #define TM_BROADCAST_IP "127.0.0.1"
  #define TM_BROADCAST_PORT "7072"
  #define CMD_TRANSMIT_IP "127.0.0.1"
  #define CMD_TRANSMIT_PORT "9090"
#elif defined(TEST_VALENTINE)
  /* FortNort as flight, EAS-NALLEN1L as PGS */
  #define TM_BROADCAST_IP "192.168.7.136"
  #define TM_BROADCAST_PORT "7072"
  #define CMD_TRANSMIT_IP "192.168.7.107"
  #define CMD_TRANSMIT_PORT "9090"
#elif defined(TEST_OXFORD_STREET)
  /* spi1 as flight, EAS-NALLEN1L as PGS */
  #define TM_BROADCAST_IP "10.245.83.21"
  #define TM_BROADCAST_PORT "7072"
  #define CMD_TRANSMIT_IP "10.245.83.83"
  #define CMD_TRANSMIT_PORT "9090"
#elif defined(TEST_OXFORD_STREET_2)
  /* spi1 as flight, EAS-NALLEN1L as PGS */
  #define TM_BROADCAST_IP "10.245.83.21"
  #define TM_BROADCAST_PORT "17072"
  #define CMD_TRANSMIT_IP "10.245.83.83"
  #define CMD_TRANSMIT_PORT "9090"
#else
  #define TM_BROADCAST_IP "10.11.96.131"
  #define TM_BROADCAST_PORT "7072"
  #define CMD_TRANSMIT_IP "10.15.101.131"
  #define CMD_TRANSMIT_PORT "9090"
#endif

/* Old alternative test configurations:
      new UDPbcast("192.168.7.255", "7072",1000); // Home LAN
      new UDPbcast("10.245.83.127", "5100"); // Link LAN
      new UDPbcast("192.168.237.255", "5100"); // VMware private LAN
*/

#endif
