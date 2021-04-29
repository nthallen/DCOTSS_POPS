README.network.txt

The DPOPS flight computer is a Raspberry Pi 4B with a
Waveshare Ethernet/USB Hub Hat https://www.waveshare.com/eth-usb-hub-hat.htm

Eth0 is the Ethernet jack on the Pi4B and is normally cabled directly to
the POPS instrument. Eth1 is the Ethernet jack on the Hat and is directly
cabled to the feedthrough connector on the front panel.

The network configuration we have been using is:

Host Intf Mode  IP
-----------------------------------------------
POPS      Fixed 10.11.97.50
Pi4B Eth0 Fixed 10.11.97.100
Pi4B Eth1 DHCP with fixed IP wherever we use it
GSE       DHCP

DHCP is Dynamic Host Configuration Protocol, which allocates IP addresses
as needed to connecting systems. It is not a feature of every network,
and some networks that provide DHCP may only provide addresses to
previously registered machines.

If the machine in question is a desktop machine, what IP it gets does
not really matter, since all network activity will originate on the
machine. If the machine is instead a server of some kind, then the
client machines need to know its IP address in order to establish
their connection. That generally means that the server needs a known,
fixed IP address. For our purposes, the Pi4B is a server, and any GSE
that wishes to access it will need to know its IP address.

There are generally two ways to get a "fixed" IP address.
The first is to configure the machine with a static IP address that
it will always use. The second is to configure DHCP at each site
to always assign the same IP address to the machine (which may likely
be different between sites). That is the cleanest approach and the one
I have used when operating the Pi4Bs both at my home and in the lab.
I have administrative access to the DHCP servers in both locations,
so that works well.

In the field, we expect to operate the instrument in at least two
different locations, if not three:
  - In the lab on the NASA "extranet"
  - On the aircraft, on the aircraft network
  - At the hotel, perhaps point-to-point

The lab network is managed by NASA IT security, so getting configurations
set or changed takes some work. On the aircraft, there is no DHCP,
and fixed IP addresses will be assigned by Carl Sorenson.

I have requested a DHCP-assigned fixed IP for DPOPS on the extranet. 
The plan is to configure Eth1 to look for DHCP but fallback to the 
fixed aircraft address. That means it will generally just work. If
the extranet IP comes through before you get there, then you should
be able to access the Pi4B directly via ssh. If we get a non-fixed
address, then the trick is figuring out what that address is so we
can connect.


Fallback Strategy to Discover or Configure Pi4B IP Address:

  - Unplug Ethernet cable from Pi4B Eth0 jack
  - Cable laptop directly to Pi4B Eth0
  - Connect DPOPS external RJ45 to extranet
  - Power up Pi4B
  - Configure laptop to use IPv4 fixed IP 10.11.97.102
  - ssh pi@10.11.97.100

Once connected, you can query the network configuration:
  
  $ ipconfig
  
You should see that Eth0 is configured as 10.11.97.100, and you
should be able to see what IP, if any, has been assigned to
Eth1. Write that down and also try to ssh in to that address.
If that works, we can copy that IP into

  /home/DPOPS/src/TM/Experiment.config

under FlightNode= (git add, commit and push!), and then distribute.

Back in one of your ssh sessions on DPOPS:

  $ sudo shutdown -h now
  
Then (30 seconds later):

  - power off DPOPS
  - disconnect Ethernet from laptop and Pi4B
  - reconnect POPS to Eth0
  - power up DPOPS
  $ cd /home/DPOPS
  $ ./doit

You may also want to restore your laptop's Ethernet configuration
to use DHCP by default.

There are two PowerShell scripts in this directory that can
facilitate switching between fixed and dynamic addressing
on your Ethernet.

  - GSE_Static_IP.ps1
  - GSE_Set_DHCP.ps1

If you open them in an editor, they include instructions on how
to invoke them. One or both may emit errors but nevertheless
accomplish their goal. If you are comfortable making the changes
manually, that is fine as well.
