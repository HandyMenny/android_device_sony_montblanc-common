#!/system/bin/sh
MAC_FILE=/data/etc/wlan_macaddr
MOD_PATH="/system/lib/modules"
MOD_CORE="cw1200_core.ko"
MOD_WLAN="cw1200_wlan.ko"
ARG="macaddr="
path=/data/misc
copy(){
i=$path/$5$1
if [ ! -f $i ]; then
   cp /system/etc/$4$1 $i
   chown $2 $i
   chmod $3 $i
fi
}

cp -f /system/etc/ril_config $path/ril_config
cp -f /system/etc/psdata/* $path/psdata/
chmod 660 $path/ril_config $path/psdata/sterc_conf* $path/psdata/stepscc_conf
chmod 500 $path/psdata/sterc_script_*
chown root:radio $path/ril_config $path/psdata/sterc_conf* $path/psdata/stepscc_conf

# Clean the DHCP leases before starting
rm -f $path/dhcp/dhcpcd-wlan0.lease
rm -f $path/dhcp/dhcpcd-wlan0.pid

# Copy dhcpcd.conf, hostap.conf, wpa_supplicant.conf to data if they dont exist
copy wifi/hostapd.conf system:wifi 660
copy wifi/wpa_supplicant.conf wifi:wifi 660
copy dhcpcd.conf dhcp:dhcp 660 dhcpcd/ dhcp/

# Create ipconfig.txt if it doesnt exists (Needed for WifiConfigStore)
ip=$path/wifi/ipconfig.txt
if [ ! -f $ip ]; then
    touch $ip
    chown system.wifi $ip
fi

# Install wlan
if ( ls $MAC_FILE > /dev/null ); then
     ADDR=`cat $MAC_FILE`
     insmod $MOD_PATH/$MOD_CORE $ARG$ADDR
else
     insmod $MOD_PATH/$MOD_CORE
fi

insmod $MOD_PATH/$MOD_WLAN
