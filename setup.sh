#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "Must be run as root"
   exit 1
fi

print_separator() {
    python3 -c 'print("-"*30)'
}

echo "👋 Update Package "
print_separator
apt update > /dev/null

echo "🛠️ Install Kali Default tools"
print_separator
apt install kali-defaults -y > /dev/null

echo "🪟Install Kali xfce"
print_separator
apt install kali-desktop-xfce -y > /dev/null
startx > /dev/null

echo "👁️ Install VNC Server"
print_separator
apt install -y novnc x11vnc > /dev/null

mkdir -p ~/.vnc
cat <<EOT > ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOT

chmod +x ~/.vnc/xstartup

echo "🎖️ Create VNC service"
print_separator
cp ./vncserver.service /etc/systemd/system/vncserver.service
systemctl daemon-reload
echo "framebuffer_width=1920" >> /boot/config.txt
echo "framebuffer_height=1080" >> /boot/config.txt
echo "hdmi_force_hotplug=1" >> /boot/config.txt


echo "🏁 Launch and enable VNC service"
print_separator
systemctl enable vncserver
systemctl start vncserver

echo "✅ Everything ready"
