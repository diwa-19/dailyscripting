################################
##FIRST TIME SETUP HOST CONFIG##
################################
#SNMP
$loopSnmp=$null
while($loopSnmp -ne '1')
{
    $isnmp = Read-Host 'Do you want install SNMP ? [y/n]'
    if($isnmp -eq 'y')
    {
        $loopSnmp=1
        write-host 'Proses instalasi SNMP akan berlangsung ..'
        Start-Sleep -S 1
        #Install SNMP service
        Install-WindowsFeature SNMP-Service -IncludeAllSubFeature -IncludeManagementTools
        echo 'Install SNMP-Service & Management Tools | OK!'
        Start-Sleep -S 1
        echo 'Configure SNMP Start'
        Start-Sleep -S 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent" -Name "sysContact" -Value "support@mybati.co.id" -type String
        echo '(+) Agent Contact support@mybati.co.id | OK!'
        Start-Sleep -S 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\SNMP\Parameters\RFC1156Agent" -Name "sysLocation" -Value "DKI Jakarta" -type String
        echo '(+) Agent Location DKI Jakarta | OK!'
        Start-Sleep -S 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\ValidCommunities" -Name "batimonitoring" -Value 4 -type DWord
        echo '(+) Security community batimonitoring | OK!'
        Start-Sleep -S 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "1" -Value "localhost" -type String
        echo '(+) Security allow host localhost | OK!'
        Start-Sleep -S 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "2" -Value "103.18.133.169" -type String
        echo '(+) Security allow sysmon host 103.18.133.169 | OK!'
        Start-Sleep -S 1
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\PermittedManagers" -Name "3" -Value "103.18.133.200" -type String
        echo '(+) Security allow prtg host 103.18.133.200 | OK!'
        New-NetFirewallRule -DisplayName "Allow SNMP Port" -Direction inbound -Profile Any -Action Allow -LocalPort 161 -Protocol UDP *>$null
        echo '(+) [Firewall] Inbound SNMP Port UDP 161 firewall | OK!'
        Start-Sleep -S 1
        echo 'Now restarting service SNMP'
        Restart-Service -Name SNMP
        echo 'Configure SNMP Done'
    }
    elseif($isnmp -eq 'n')
    {
        $loopSnmp=1
        write-host 'Proses instalasi SNMP tidak dibutuhkan ..'
    }
    else
    {
        $loopSnmp=0
        write-host 'Input salah! silahkan input kembali ..'
    }
}

#DCOM
$loopDcom=$null
while($loopDcom -ne '1')
{
    $idcom = Read-Host 'Do you want Configure DCOM ? [y/n]'
    if($idcom -eq 'y')
    {
        $loopDcom=1
        write-host 'Proses konfigurasi DCOM akan berlangsung ..'
        Start-Sleep -S 1
        #Configure DCOM service
        New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Ole\AppCompat' -Name "RequireIntegrityActivationAuthenticationLevel" -PropertyType "DWORD" -Value "0" -Force *>$null
        echo '(+) [Regedit] RequireIntegrityActivationAuthenticationLevel DCOM | OK!'
        Start-Sleep -S 1
        New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Ole\' -Name "LegacyAuthenticationLevel" -PropertyType "DWORD" -Value "5" -Force *>$null
        echo '(+) [Regedit] Default Authentication Level DCOM modify to Packet Integrity | OK!'
        Start-Sleep -S 1
    }
    elseif($idcom -eq 'n')
    {
        $loopDcom=1
        write-host 'Proses konfigurasi DCOM tidak dibutuhkan ..'
    }
    else
    {
        $loopDcom=0
        write-host 'Input salah! silahkan input kembali ..'
    }
}

#VEEAM Firewall
$loopVeeam=$null
while($loopVeeam -ne '1')
{
    $iVeeam = Read-Host 'Do you want Configure Firewall Veeam ? [y/n]'
    if($iVeeam -eq 'y')
    {
        $loopVeeam=1
        write-host 'Proses konfigurasi Firewall Veeam akan berlangsung ..'
        Start-Sleep -S 1
        $rVeeam = Read-Host 'Mohon input IP Backup Veeam tujuan | Ex : 192.168.80.x '
        #Configure Veeam Firewall
        New-NetFirewallRule -DisplayName "Allow Veeam" -Direction inbound -Profile Any -Action Allow -RemoteAddress "$rVeeam" -Protocol Any *>$null
        echo '(+) [Firewall] Inbound Rule for Veeam Backup | OK!'
        Start-Sleep -S 1
    }
    elseif($iVeeam -eq 'n')
    {
        $loopVeeam=1
        write-host 'Proses konfigurasi Firewall Veeam tidak dibutuhkan ..'
    }
    else
    {
        $loopVeeam=0
        write-host 'Input salah! silahkan input kembali ..'
    }
}

#ICMP Firewall
$loopIcmp=$null
while($loopIcmp -ne '1')
{
    $iIcmp = Read-Host 'Do you want Configure Firewall ICMPv4 ? [y/n]'
    if($iIcmp -eq 'y')
    {
        $loopIcmp=1
        write-host 'Proses konfigurasi Firewall ICMPv4 akan berlangsung ..'
        Start-Sleep -S 1
        #Configure ICMP Firewall
        New-NetFirewallRule -DisplayName "Allow ICMPv4" -Direction inbound -Profile Any -Action Allow -Protocol ICMPv4 *>$null
        echo '(+) [Firewall] Inbound Rule for ICMPv4 | OK!'
        Start-Sleep -S 1
    }
    elseif($iIcmp -eq 'n')
    {
        $loopIcmp=1
        write-host 'Proses konfigurasi Firewall ICMPv4 tidak dibutuhkan ..'
    }
    else
    {
        $loopIcmp=0
        write-host 'Input salah! silahkan input kembali ..'
    }
}

#RDP Port
$loopRdp=$null
while($loopRdp -ne '1')
{
    $iRdp = Read-Host 'Do you want Configure RDP Port ? [y/n]'
    if($iRdp -eq 'y')
    {
        $loopRdp=1
        write-host 'Proses konfigurasi RDP Port akan berlangsung ..'
        Start-Sleep -S 1
        $pRDP = Read-Host 'Mohon input port kebuthan RDP | Ex : 38899 '
        #Configure RDP Port
        New-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "PortNumber" -Value "$pRDP" -Force *>$null
        echo "(+) RDP Port $pRDP | OK!"
        New-NetFirewallRule -DisplayName "Allow RDP Port" -Direction inbound -Profile Any -Action Allow -LocalPort "$pRDP" -Protocol TCP *>$null
        echo "(+) [Firewall] Inbound RDP Port TCP $pRDP firewall | OK!"
        Start-Sleep -S 1
    }
    elseif($iRdp -eq 'n')
    {
        $loopRdp=1
        write-host 'Proses konfigurasi RDP Port tidak dibutuhkan ..'
    }
    else
    {
        $loopRdp=0
        write-host 'Input salah! silahkan input kembali ..'
    }
}