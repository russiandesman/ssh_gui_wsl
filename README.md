# ssh_gui_wsl

## Why is it needed?

Standard way to run GUI apps in WSL is to set $DISPLAY to host's IP, install some X-server and be happy.

**But.** Your domain admin may decide to close X11 ports by Windows firewall (why? why!?)

Then our friend SSH comes to rescue.

## Deploy

1. Install WSL
1. Install Git there, clone this repo.
1. Install VcXsrv from https://sourceforge.net/projects/vcxsrv/
1. Run bootstrap_wsl.sh from WSL console
1. Go to %userprofile%\WSL on your Windows host, run setup.vbs
1. Reboot
1. Run **x_port_forward** from desktop. Repeat after **each** VPN connect-disconnect.
1. Now you can run Far2l from your desktop.
1. Also you can run any other GUI app from WSL, you need to prepend the call by **DISPLAY=localhost:0**
    * **DISPLAY=localhost:0 xeyes** for example

## Troubleshooting

1. If you started Far2l and see nothing -- most probably you did not start **x_port_forward**
1. Still nothing -- check whether VcXSrv is started -- tray icon is your friend here.
1. setup.vbs is safe to run multiple times, uncomment Echo there and see what happen.

## Final clauses

I tried to make this a usable product.

If something went wrong -- don't hesitate to open issue on GitHub

