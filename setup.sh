#!/bin/bash

echo "To begin with, you will need to set the wifi region/country"
read -rp "Press enter to continue"

# Update the pi and install goodies
echo "Updating and installing essential programs"
sudo apt update && sudo apt upgrade -y
sudo apt install -y mpv emacs

# Set the audio output to HDMI
# Use pactl list short sinks to list options, but hopefully if using pi 4s the hardware is the same
echo "Setting HDMI audio out as the default sound output"
pactl set-default-sink 76

# Create the autostart file for the user (not the system)

if [ ! -d "$HOME/.config/lxsession" ]
   then
       echo "Creating autostart file"
       mkdir "$HOME/.config/lxsession"
       mkdir "$HOME/.config/lxsession/LXDE-pi"
       cp -v /etc/xdg/lxsession/LXDE-pi/autostart "$HOME/.config/lxsession/LXDE-pi/"
       # Add the stuff we want to it
       STARTUP="$HOME/.config/lxsession/LXDE-pi/autostart"
       echo "@vlc -L --no-osd -f $HOME/Videos" >> "$STARTUP"
else
    echo "$HOME/.config/lxsession/LXDE-pi/autostart exists, not creating the startup."
fi

# Install the teamviewer binary
# Just going to download it, as it doesn't really work with wayland now
echo "Downloading Teamviewer deb in case you need it."
wget -p "$HOME/Downloads" https://download.teamviewer.com/download/linux/teamviewer-host_arm64.deb
# yes | sudo dpkg -i ~/Downloads/teamviewer-host_arm64.deb
# Installs dependencies for teamviewer
# sudo apt-get install -fy
# teamviewer &

echo "Lastly, you need to enable VNC support"
echo "A gui will appear. In it"
echo "please go to |Interfaces| and toggle VNC"
read -rp "Press enter to continue"
rc-gui
