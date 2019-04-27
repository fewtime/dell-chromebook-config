#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
usersxhkd=$HOME/.config/sxhkd/sxhkdrc
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


twm &
xclock -geometry 50x50-1+1 &
xterm -geometry 80x50+494+51 &
xterm -geometry 80x20+494-0 &
fcitx &
exec xterm -geometry 80x66+0+0 -name login
exec --no-startup-id sxhkd &
# exec ibus-daemon --xim --daemonize
exec compton -b &
exec mpd $HOME/.config/mpd/mpd.conf
exec i3
