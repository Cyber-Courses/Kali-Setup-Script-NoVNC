#!/bin/bash
echo "👋 Update Package "
python3 -c 'print("-"*30)'
apt update

echo "🛠️ Install Kali Default tools"
python3 -c 'print("-"*30)'
apt install kali-default-tools -y

echo "🪟Install Kali xfce"
python3 -c 'print("-"*30)'
apt install kali-desktop-xfce -y

echo "👁️ Install VNC Server"
python3 -c 'print("-"*30)'
apt install -y novnc x11vnc

echo "🎖️ Create VNC service"
python3 -c 'print("-"*30)'
cp ./vncserver.service /etc/systemd/system/vncserver.service
echo "framebuffer_width=1920" >> /boot/config.txt
echo "framebuffer_height=1080" >> /boot/config.txt
echo "hdmi_force_hotplug=1" >> /boot/config.txt


echo "🏁 Launch and enable VNC service"
python3 -c 'print("-"*30)'
systemctl enable vncserver
systemctl start vncserver
systemctl status vncserver

