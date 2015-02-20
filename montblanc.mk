# ste-sony
$(call inherit-product, hardware/ste-sony/common.mk)

# Inherit from the vendor common montblanc definitions
$(call inherit-product-if-exists, vendor/sony/montblanc-common/montblanc-common-vendor.mk)

# Common montblanc settings overlays
DEVICE_PACKAGE_OVERLAYS += device/sony/montblanc-common/overlay

# Common montblanc features
PRODUCT_COPY_FILES += \
        frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
        frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
        frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
        frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
        frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
        frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
        frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
        frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
        frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
        frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
        frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
        frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
        frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
        frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
        frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
        frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
        frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Configuration files
PRODUCT_COPY_FILES += \
        device/sony/montblanc-common/config/media_codecs.xml:system/etc/media_codecs.xml \
        device/sony/montblanc-common/config/egl.cfg:system/lib/egl/egl.cfg \
        device/sony/montblanc-common/config/asound.conf:system/etc/asound.conf \
        device/sony/montblanc-common/config/hostapd.conf:system/etc/wifi/hostapd.conf \
        device/sony/montblanc-common/config/01stesetup:system/etc/init.d/01stesetup \
        device/sony/montblanc-common/config/10wireless:system/etc/init.d/10wireless \
        device/sony/montblanc-common/config/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
        device/sony/montblanc-common/config/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf

# Google && ffmpeg Codecs
PRODUCT_COPY_FILES += \
        frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
        frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
        frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
        frameworks/av/media/libstagefright/data/media_codecs_ffmpeg.xml:system/etc/media_codecs_ffmpeg.xml

# Filesystem management tools
PRODUCT_PACKAGES += setup_fs
   
# libtinyalsa & audio.usb.default
PRODUCT_PACKAGES += \
        tinyalsa \
        libtinyalsa \
        audio.usb.default
       
# Hostapd & WIFI
PRODUCT_PACKAGES += \
        hostapd_cli \
        hostapd \
        wpa_supplicant \
        wpa_cli \
        libwpa_client

# BlueZ
PRODUCT_PACKAGES += \
        libglib \
        bluetoothd \
        bluetooth.default \
        haltest \
        btmon \
        btproxy \
        audio.a2dp.default \
        l2test \
        bluetoothd-snoop \
        init.bluetooth.rc \
        btmgmt \
        hcitool \
        l2ping \
        avtest \
        libsbc \
        hciattach

# Run adbd as root
ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0

# Default USB configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.sys.usb.config=mtp

# Custom init scripts
PRODUCT_COPY_FILES += \
        device/sony/montblanc-common/config/init.st-ericsson.rc:root/init.st-ericsson.rc \
        device/sony/montblanc-common/config/ueventd.st-ericsson.rc:root/ueventd.st-ericsson.rc

# Hardware configuration scripts
PRODUCT_COPY_FILES += \
        device/sony/montblanc-common/config/omxloaders:system/etc/omxloaders \
        device/sony/montblanc-common/config/ril_config:system/etc/ril_config \
        device/sony/montblanc-common/config/restorecon_modemfs.sh:system/etc/restorecon_modemfs.sh \
        device/sony/montblanc-common/config/install_wlan.sh:system/bin/install_wlan.sh \
        device/sony/montblanc-common/config/ste_modem.sh:system/etc/ste_modem.sh \
        device/sony/montblanc-common/config/gps.conf:system/etc/gps.conf \
        device/sony/montblanc-common/config/cacert.txt:system/etc/suplcert/cacert.txt

# Copy input device configurations
PRODUCT_COPY_FILES += \
        device/sony/montblanc-common/config/sensor00_f11_sensor0.idc:system/usr/idc/sensor00_f11_sensor0.idc \
        device/sony/montblanc-common/config/synaptics_rmi4_i2c.idc:system/usr/idc/synaptics_rmi4_i2c.idc

