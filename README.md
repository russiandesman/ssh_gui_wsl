# ssh_gui_wsl

## Why is it needed?

Standard way to run GUI apps in WSL is to sed $DISPLAY to host's IP, install some X-server and be happy.

But. Your domain admin may decide to close X11 ports by Windows firewall (why? why!?)

Then our friend SSH comes to rescue.

Internal openssh (as of now) cannot forward X11 traffic to host's X-server.

Luckily VcXsrv bundled with plink from putty.

## Deploy

1. Install WSL
1. Install VcXsrv from https://sourceforge.net/projects/vcxsrv/
1. Run bootstrap_wsl.sh from wsl console
1. Go to %userprofile%\WSL on your Windows host, run cmd
1. Change dir to where you installed VcXsrv, run %userprofile%\WSL\run_once_in_xserver_dir.bat
1. Reboot
1. Now you can run ssh_to_wsl.bat for console access or far_wsl.bat for GUI access

## Congratulations

