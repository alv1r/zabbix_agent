SETLOCAL ENABLEDELAYEDEXPANSION
REM Determinate your domain postfix local/com/ru
SET String=%computername%.%userdomain%.local
REM Determinate Zabbix Server address
SET Zabbix=192.168.10.31
SET String
CALL :LoCase String
SET String
ENDLOCAL
GOTO:EOF

:LoCase
:: Subroutine to convert a variable VALUE to all lower case.
:: The argument for this subroutine is the variable NAME.
SET %~1=!%1:A=a!
SET %~1=!%1:B=b!
SET %~1=!%1:C=c!
SET %~1=!%1:D=d!
SET %~1=!%1:E=e!
SET %~1=!%1:F=f!
SET %~1=!%1:G=g!
SET %~1=!%1:H=h!
SET %~1=!%1:I=i!
SET %~1=!%1:J=j!
SET %~1=!%1:K=k!
SET %~1=!%1:L=l!
SET %~1=!%1:M=m!
SET %~1=!%1:N=n!
SET %~1=!%1:O=o!
SET %~1=!%1:P=p!
SET %~1=!%1:Q=q!
SET %~1=!%1:R=r!
SET %~1=!%1:S=s!
SET %~1=!%1:T=t!
SET %~1=!%1:U=u!
SET %~1=!%1:V=v!
SET %~1=!%1:W=w!
SET %~1=!%1:X=x!
SET %~1=!%1:Y=y!
SET %~1=!%1:Z=z!
echo Server=%Zabbix% >> .\conf\zabbix_agentd.conf
echo ServerActive=%Zabbix% >> .\conf\zabbix_agentd.conf
echo Hostname=%String% >> .\conf\zabbix_agentd.conf
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
GOTO:EOF
