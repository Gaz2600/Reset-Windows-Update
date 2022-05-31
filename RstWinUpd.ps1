Write-Host "1. Stopping Windows Update Services..." 
Stop-Service -Name BITS -Force
Stop-Service -Name wuauserv -Force
Stop-Service -Name cryptsvc -Force
 
Write-Host "2. Remove QMGR Data file..." 
Remove-Item -Path "$env:allusersprofile\Application Data\Microsoft\Network\Downloader\qmgr*.dat" -ErrorAction SilentlyContinue 
 
Write-Host "3. Removing the Software Distribution and CatRoot Folder..." 
Remove-Item -Path "$env:systemroot\SoftwareDistribution" -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$env:systemroot\System32\Catroot2" -ErrorAction SilentlyContinue -Recurse
 
Write-Host "4. Resetting the Windows Update Services to defualt settings..." 
Start-Process "sc.exe" -ArgumentList "sdset bits D:(A;CI;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)"
Start-Process "sc.exe" -ArgumentList "sdset wuauserv D:(A;;CCLCSWRPLORC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)"
 
Set-Location $env:systemroot\system32 
 
Write-Host "5. Registering some DLLs..." 
regsvr32.exe atl.dll /s
regsvr32.exe urlmon.dll /s
regsvr32.exe mshtml.dll /s
regsvr32.exe shdocvw.dll /s
regsvr32.exe browseui.dll /s
regsvr32.exe jscript.dll /s
regsvr32.exe vbscript.dll /s
regsvr32.exe scrrun.dll /s
regsvr32.exe msxml.dll /s
regsvr32.exe msxml3.dll /s
regsvr32.exe msxml6.dll /s
regsvr32.exe actxprxy.dll /s
regsvr32.exe softpub.dll /s
regsvr32.exe wintrust.dll /s
regsvr32.exe dssenh.dll /s
regsvr32.exe rsaenh.dll /s
regsvr32.exe gpkcsp.dll /s
regsvr32.exe sccbase.dll /s
regsvr32.exe slbcsp.dll /s
regsvr32.exe cryptdlg.dll /s
regsvr32.exe oleaut32.dll /s
regsvr32.exe ole32.dll /s
regsvr32.exe shell32.dll /s
regsvr32.exe initpki.dll /s
regsvr32.exe wuapi.dll /s
regsvr32.exe wuaueng.dll /s
regsvr32.exe wuaueng1.dll /s
regsvr32.exe wucltui.dll /s
regsvr32.exe wups.dll /s
regsvr32.exe wups2.dll /s
regsvr32.exe wuweb.dll /s
regsvr32.exe qmgr.dll /s
regsvr32.exe qmgrprxy.dll /s
regsvr32.exe wucltux.dll /s
regsvr32.exe muweb.dll /s
regsvr32.exe wuwebv.dll /s
 
Write-Host "6) Resetting the WinSock..." 
netsh winsock reset 

Write-Host "7) Starting Windows Update Services..." 
Start-Service -Name BITS 
Start-Service -Name wuauserv 
Start-Service -Name cryptsvc 
 
Write-Host "8) Forcing discovery..." 
#wuauclt /resetauthorization /detectnow 
USOClient.exe RefreshSettings
USOClient.exe StartScan
 
Write-Host "Process complete. Please reboot your computer."
