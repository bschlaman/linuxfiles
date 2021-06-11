#!/bin/sh

cat << EOF >> /etc/systemd/network/wlan0.network
[Match]
Name=wlan0

[Network]
DHCP=yes
EOF

SSID=$1
PASS=$2

wpa_passphrase "${SSID}" "${PASS}" > /etc/wpa_supplicant/wpa_supplicant-wlan0.conf

# ln -s \
# 	/usr/lib/systemd/system/wpa_supplicant@.service \
# 	/etc/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service

