#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "Must be run as root"
   exit 1
fi

print_separator() {
    python3 -c 'print("-"*30)'
}

print_separator
echo "👋 Update Package List"
print_separator
apt update

print_separator
echo "🛠️ Install Kali Default tools"
print_separator
apt install kali-defaults -y

print_separator
echo "🪟Install xfce"
print_separator
apt install kali-desktop-xfce xfce4-goodies -y

print_separator
echo "👁️ Install VNC Server"
print_separator
apt install -y novnc tightvncserver websockify

print_separator
echo "🔧 Auto remove unused packages"
print_separator
apt autoremove -y

print_separator
echo "🎖️ Create VNC & NoVNC services"
print_separator

apt install -y locales
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en

mkdir -p /home/kali/.vnc
chown kali:kali /home/kali/.vnc

cat <<EOL > /home/kali/.vnc/xstartup
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4 &
EOL

chmod +x /home/kali/.vnc/xstartup
chown kali:kali /home/kali/.vnc/xstartup

echo "password" | vncpasswd -f > /home/kali/.vnc/passwd
chmod 600 /home/kali/.vnc/passwd
chown kali:kali /home/kali/.vnc/passwd

cp ./vncserver.service /etc/systemd/system/vncserver.service
cp ./novnc.service /etc/systemd/system/novnc.service
systemctl daemon-reload


echo "🏁 Launch and enable VNC & NoVNC services"
print_separator
systemctl enable vncserver
systemctl start vncserver
systemctl enable novnc
systemctl start novnc

echo "✅ Everything ready"
