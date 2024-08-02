#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "Must be run as root"
   exit 1
fi

print_separator() {
    python3 -c 'print("-"*30)'
}

print_separator
echo "👋 Update Package "
print_separator
apt update

print_separator
echo "🛠️ Install Kali Default tools"
print_separator
apt install kali-defaults -y

print_separator
echo "🪟Install Kali xfce"
print_separator
apt install kali-desktop-xfce -y

print_separator
echo "👁️ Install VNC Server"
print_separator
apt install -y novnc x11vnc xvfb
apt autoremove

print_separator
echo "🎖️ Create VNC service"
print_separator

cat <<EOT > /usr/local/bin/start_x11vnc.sh
#!/bin/bash
# Start the XFCE desktop environment
xvfb-run :1 -screen 0 1920x1080x16 & startxfce4 --display :1 &

# Start x11vnc server
/usr/bin/x11vnc -display :0 -autoport -localhost -nopw -bg -xkb -ncache -ncache_cr -quiet -forever

# Start novnc
/usr/share/novnc/utils/novnc_proxy --listen 8081 --vnc localhost:5900
EOT

chmod 700 /usr/local/bin/start_x11vnc.sh

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
