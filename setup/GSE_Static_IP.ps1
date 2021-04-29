# ----------
# Invocation:
# ----------
# 
# This script can be run from a Windows Cmd shell as:
# > PowerShell -ExecutionPolicy Bypass ./GSE_Static_IP.ps1

# This is the elevation check and elevation
$is_admin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")
if (-NOT $is_admin) {
  # $myinvocation | Format-List | Write-Output
  # $myinvocation.mycommand | Format-List | Write-Output
  $cmdline = $myinvocation.Line.Replace($myinvocation.InvocationName, $myinvocation.mycommand.definition)
  Write-Verbose "Invocation: $cmdline"
  Write-Warning "You do not have Administrator rights"
  Write-Warning "Will attempt to RunAs Administrator"
# $cont = Read-Host -Prompt "Continue? [N/y]"
# if ( $cont -match 'y(es)?' ) {
    Write-Output "Restarting script as Administrator"
    $cmdline = "-ExecutionPolicy Bypass $cmdline"
    Start-Process -FilePath PowerShell.exe -ArgumentList "$cmdline" -Verb RunAs # -Wait
    Write-Verbose "Back from RunAs"
    Write-Verbose "Could conceivably run the bash script now"
    # $cont = Read-Host -Prompt "Finish?"
# }
  Break # So we don't try to do the privileged stuff
}

$IP = "10.11.97.102"
$MaskBits = 24 # This means subnet mask = 255.255.255.0
$Gateway = "10.11.97.1"
# $Dns = "10.10.10.100"
$IPType = "IPv4"
# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter -Name "Ethernet"
# Remove any existing IP, gateway from our ipv4 adapter

Write-Output "${IPType}:$IP/$MaskBits"
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
  $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
  Write-Output "Removed old IPv4 Address"
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
  $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
  Write-Output "Removed old IPv4 Default Gateway"
}
$interface = $adapter | Get-NetIPInterface -AddressFamily $IPType
If ($interface.Dhcp -eq "Enabled") {
  $interface | Set-NetIPInterface -DHCP Disabled
  Write-Output "DHCP Disabled"
  if ($interface.Dhcp -eq "Enabled") {
    Write-Output "But it did not take"
  }
}
 # Configure the IP address and default gateway
$adapter | New-NetIPAddress `
  -AddressFamily $IPType `
  -IPAddress $IP `
  -PrefixLength $MaskBits `
  -DefaultGateway $Gateway

Write-Output "Set IPv4 Static IP $IP/$MaskBits"

# Configure the DNS client server IP addresses
# $adapter | Set-DnsClientServerAddress -ServerAddresses $DNS

$cont = Read-Host -Prompt "Finish?"
