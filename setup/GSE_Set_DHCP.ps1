# ----------
# Invocation:
# ----------
# 
# This script can be run from a Windows Cmd shell as:
# > PowerShell -ExecutionPolicy Bypass ./GSE_Set_DHCP.ps1

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

$IPType = "IPv4"
$adapter = Get-NetAdapter -Name "Ethernet"
$interface = $adapter | Get-NetIPInterface -AddressFamily $IPType
If ($interface.Dhcp -eq "Disabled") {
  Write-Output "DHCP was Disabled"
 # Remove existing gateway
 If (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) {
   $interface | Remove-NetRoute -Confirm:$false
   Write-Output "Removed IPv4 Default Gateway"
 }
 # Enable DHCP
 $interface | Set-NetIPInterface -DHCP Enabled
 # Configure the DNS Servers automatically
 $interface | Set-DnsClientServerAddress -ResetServerAddresses
 Write-Output "Enabled DHCP and cleared DNS Server Address"
} else {
  Write-Output "DHCP was enabled"
}
$cont = Read-Host -Prompt "Continue? [N/y]"
