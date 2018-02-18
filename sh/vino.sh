#!/usr/bin/env bash

#
# https://jasonmun.blogspot.my
# https://github.com/yomun
# 
# Copyright (C) 2017 Jason Mun
# 
#

OS_RELEASE=`cat /etc/os-release`

if [ `echo ${OS_RELEASE} | grep -c "ubuntu"` -gt 0 ] || [ `echo ${OS_RELEASE} | grep -c "linuxmint"` -gt 0 ] || [ `echo ${OS_RELEASE} | grep -c "debian"` -gt 0 ] || [ `echo ${OS_RELEASE} | grep -c "zorin"` -gt 0 ]
then
	/usr/lib/vino/vino-server --sm-disable

	export DISPLAY=0:0
	gsettings set org.gnome.Vino require-encryption false
	
	sudo ufw enable
	sudo ufw allow 5900/tcp
	
	sudo ufw reload
	sudo ufw status
	
elif [ `echo ${OS_RELEASE} | grep -c 'ID=\"centos\"'` -gt 0 ] || [ `echo ${OS_RELEASE} | grep -c 'ID=\"rhel\"'` -gt 0 ]
then
	# CentOS-7-x86_64-Everything-1708.iso - INSTALLATION SUMMARY - SOFTWARE - SOFTWARE SELECTION
	# GNOME Desktop - Legacy X Window System Compatibility
	# 用 CentOS-7-x86_64-LiveGNOME-1708.iso 可能会出现黑屏
	# yum groupinstall "X Window System"
	
	dbus-launch gsettings set org.gnome.Vino require-encryption false
	dbus-launch gsettings set org.gnome.Vino notify-on-connect false
	dbus-launch gsettings set org.gnome.Vino prompt-enabled false
	
	pkill vino-server
	
	export DISPLAY=:0.0
	/usr/libexec/vino-server &
	
	ZONE=`firewall-cmd --get-active-zones | head -n1`

	sudo firewall-cmd --add-port=5900/tcp --permanent --zone=${ZONE}
	sudo firewall-cmd --add-service=vnc-server --permanent --zone=${ZONE}
	
	# sudo firewall-cmd --remove-port=5900/tcp --permanent --zone=${ZONE}
	# sudo firewall-cmd --remove-service=vnc-server --permanent --zone=${ZONE}

	sudo firewall-cmd --reload
	sudo firewall-cmd --list-all --zone=${ZONE}

elif [ `echo ${OS_RELEASE} | grep -c 'ID=fedora'` -gt 0 ]
then
	dbus-launch gsettings set org.gnome.Vino require-encryption false
	dbus-launch gsettings set org.gnome.Vino notify-on-connect false
	dbus-launch gsettings set org.gnome.Vino prompt-enabled false
	
	pkill vino-server
	
	export DISPLAY=:0.0
	/usr/libexec/vino-server &
	
	ZONE=`firewall-cmd --get-active-zones | head -n1`

	sudo firewall-cmd --add-port=5900/tcp --permanent --zone=${ZONE}
	sudo firewall-cmd --add-service=vnc-server --permanent --zone=${ZONE}
	
	# sudo firewall-cmd --remove-port=5900/tcp --permanent --zone=${ZONE}
	# sudo firewall-cmd --remove-service=vnc-server --permanent --zone=${ZONE}
	
	sudo firewall-cmd --reload
	sudo firewall-cmd --list-all --zone=${ZONE}

elif [ `echo ${OS_RELEASE} | grep -c "opensuse"` -gt 0 ]
then
	# 开启端口 5900
	# http://jasonmun.blogspot.my/2017/01/opensuse-firewall.html
	
	# systemctl enable NetworkManager
	# systemctl start NetworkManager

	dbus-launch gsettings set org.gnome.Vino require-encryption false
	dbus-launch gsettings set org.gnome.Vino notify-on-connect false
	dbus-launch gsettings set org.gnome.Vino prompt-enabled false
	
	pkill vino-server
	
	export DISPLAY=:0.0
	/usr/lib/vino/vino-server --sm-disable

elif [ `echo ${OS_RELEASE} | grep y-c "mageia"` -gt 0 ]
then
	echo ""
elif [ `echo ${OS_RELEASE} | grep -c "manjaro"` -gt 0 ] || [ `echo ${OS_RELEASE} | grep -c "antergos"` -gt 0 ]
then
	echo ""
elif [ `echo ${OS_RELEASE} | grep -c "solus"` -gt 0 ]
then
	echo ""
fi
