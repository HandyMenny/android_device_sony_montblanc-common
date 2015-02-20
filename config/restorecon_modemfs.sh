#!/system/bin/sh

if [ $(ls -Z | grep -c modem_file) -lt 9 ]; then
	busybox restorecon -R /modemfs
fi;
