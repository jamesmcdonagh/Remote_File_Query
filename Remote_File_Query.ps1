
##########################################################
# ARCHIVE LOCATOR #
##########################################################

$filetofind = 'archive.pst'
# Hostnames TXT Location
$hostnamestxt = 'C:\test\hosts.txt'
# Destination file for Online Machines
$onlinetxt = 'C:\test\Machines_with_file.txt'
# Destination file for Offline Machines
$offlinetxt = 'C:\test\Offline_Machines.txt'

##########################################################
# Begin Executing Script #
##########################################################

$computers = get-content "$hostnamestxt"

write-host "----------------------------------------------"
write-host "Scanning hostnames from $hostnamestxt..."
write-host "----------------------------------------------"

foreach($computer in $computers)
{
     ping -n 1 $computer >$null
     if($lastexitcode -eq 0)		
     {
	if(test-path "\\$computer\c$\$filetofind")
	{
         echo "$computer" | Out-File -Append "$onlinetxt"
         write-host "File FOUND on $computer"
        }
	else
	{write-host "File NOT found on $computer"}
     }
     else
     {
      echo "$computer" | Out-File -Append "$offlinetxt"
      write-host "$computer is OFFLINE/DID NOT RESPOND TO PING"
     }
}
write-host "----------------------------------------------"
write-host "Script has completed please check output."
write-host "Hosts with file output location - $onlinetxt"
write-host "Hosts that were unpingable output location - $offlinetxt"
write-host "----------------------------------------------"