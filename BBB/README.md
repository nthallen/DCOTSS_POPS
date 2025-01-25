# POPS Beaglebone Black (BBB)
This directory contains modifications to the BBB code to facilitate
operation under control of the Raspberry Pi. This includes the
ability to startup the BBB without actually starting the POPS
data acquisition. This is useful for post-flight data processing,
since it prevents data being written hours or days after the end
of the flight.

Note that a number of items here have been updated under COSMID/POPS,
where we are using POPS instruments of a somewhat later vintage.

etc/network/interfaces: Sets fixed IP address to 10.11.97.50

etc/ntp.conf: configures the BBB to get NTP time synchronization
from 10.11.97.100, which is the Raspberry Pi.

etc/rc.local: Modified to run our POP_srvr instead of immediately
starting popsdt.

media/uSD/POPS_BBB.cfg: Backup of the POPS configuration file

opt/scripts/boot/am335x_evm.sh: Backup of startup script

srvr/: Our POPS_srvr code
