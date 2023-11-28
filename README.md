# My personal bspwm desktop

## Components

- **WM:** [bspwm](https://github.com/baskerville/bspwm)
- **OS:** [Arch Linux](https://archlinux.org)
- **Terminal:** [kitty](https://sw.kovidgoyal.net/kitty/)
- **Shell:** [zsh](https://wiki.archlinux.org/title/Zsh)
- **File Manager:** [pcmanfm](https://wiki.archlinux.org/title/PCManFM)
- **Application Launcher:** [rofi](https://github.com/davatorium/rofi)
- **Bar:** [polybar](https://github.com/polybar/polybar)
- **Compositor:** [picom](https://github.com/yshui/picom)
- **Notification:** [dunst](https://github.com/dunst-project/dunst)

> For compositor you can use dmenu insteded of rofi

```bash
# Install the necessary packages
$ sudo pacman -S bspwm dunst rofi pcmanfm picom polybar sxhkd

$ cd .config/
$ mkdir -p {bspwm,picom,polybar,bspwm,dunst,sxhkd}

# Copy the base files
$ cp /usr/share/doc/bspwm/examples/bspwmrc bspwm/
$ cp /usr/share/doc/bspwm/examples/sxhkdrc sxhkd/
$ cp /etc/polybar/config.ini polybar/
$ cp /etc/xdg/picom.conf picom.conf/
$ cp /etc/dunst/dunstrc dunst/

$ cd polybar/

# Create launch script
$ touch launch.sh
# Use a text editor to edit the file
$ EDITOR launch.sh

# Copy this to your launch.sh

#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar example &

$ cd ../bspwm/

# Turn bspwmrc executable
$ chmod +x bspwmrc
$ EDITOR bspwmrc

# Inside bspwmrc

# Copy this to the bottom of your bspwmrc
picom --config $HOME/.config/picom/picom.conf &
dunst -config $HOME/.config/dunst/dunstrc &
$HOME/.config/polybar/launch.sh &

$ cd ../sxhkd/

# You can edit sxhkd shortcuts
$ EDITOR sxhkdrc

# After you edit sxhkd shortcuts you can restart your computer and you will have a vanilla bspwm ready for you!
```
