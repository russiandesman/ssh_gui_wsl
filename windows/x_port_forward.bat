@echo off
wsl -u root service ssh start
FOR /F %%I IN ('wsl hostname -I') DO (SET WSL_IP=%%I)
FOR /F %%I IN ('wsl whoami') DO (SET WSL_USER=%%I)

rem I gave up escaping this for FOR /F, so set it via file redirection
wsl ip route show default ^| awk ^'{print $3}^' > %TEMP%\\own_ip.txt
set /p OWN_IP="" < %TEMP%\\own_ip.txt

rem how it works: ip route show default | awk '{print $3}'
rem alternative way: cat /etc/resolv.conf | grep nameserver | cut -d " " -f 2

echo user: %WSL_USER%
echo WSL instance IP: %WSL_IP%
echo Own IP in WSL net: %OWN_IP%

echo "Wait couple of seconds, then close this window"

ssh -R 6000:%OWN_IP%:6000 %WSL_USER%@%WSL_IP% -p2211 -i %USERPROFILE%\WSL\wsl_access.private -f -o StrictHostKeyChecking=no -N

echo Port forwarding setup is done
