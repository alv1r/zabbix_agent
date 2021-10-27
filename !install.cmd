@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
echo Installing Zabbix Agent x86/x64
rem check arguments
IF [%1]==[] GOTO NO_ARGUMENT
rem get computername and domain
FOR /F "usebackq tokens=*" %%a IN (`wmic.exe COMPUTERSYSTEM GET DOMAIN /Value`) DO (
      @((ECHO %%a | findstr /i /c:"Domain=") && SET _str=%%a) > NUL 2>&1
)
FOR /F "tokens=2 delims=^=" %%a IN ("%_str%") do SET _computerDomain=%%a
SET _computerDomain=%_computerDomain: =%
SET _fqdn=%COMPUTERNAME%.%_computerDomain%
rem set zabbix server address 
SET Zabbix=%1
echo Making configuration file
echo Server=%Zabbix% >> .\conf\zabbix_agentd.conf
echo ServerActive=%Zabbix% >> .\conf\zabbix_agentd.conf
echo Hostname=%_fqdn%  >> .\conf\zabbix_agentd.conf
echo ListenPort=10050  >> .\conf\zabbix_agentd.conf
echo LogFile=c:\zabbix_agent\zabbix_agentd.log >> .\conf\zabbix_agentd.conf 
echo LogFileSize=5 >> .\conf\zabbix_agentd.conf
echo EnableRemoteCommands=1 >> .\conf\zabbix_agentd.conf
echo tune firewall
netsh advfirewall firewall add rule name="Zabbix Agent" dir=out protocol=tcp localport=10050 action=allow
netsh advfirewall firewall add rule name="Zabbix Agent" dir=in protocol=tcp localport=10050 action=allow
echo installing Zabbix agent
IF EXIST "%ProgramFiles(x86)%" (".\bin\win64\zabbix_agentd.exe" --config ".\conf\zabbix_agentd.conf" --install) ELSE (".\bin\win32\zabbix_agentd.exe" --config ".\conf\zabbix_agentd.conf" --install)
echo starting service
IF EXIST "%ProgramFiles(x86)%" (".\bin\win64\zabbix_agentd.exe" --config ".\conf\zabbix_agentd.conf" --start) ELSE (".\bin\win32\zabbix_agentd.exe" --config ".\conf\zabbix_agentd.conf" --start)
echo Done
:NO_ARGUMENT
echo No argument supplied. Usage: !install.cmd IP OR FQDN
echo As an argiment you can use IP or FQDN address of zabbix server