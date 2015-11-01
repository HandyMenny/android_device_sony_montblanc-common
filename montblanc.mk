# ste-sony
$(call inherit-product, hardware/ste-sony/common.mk)

# Inherit from the vendor common montblanc definitions
$(call inherit-product-if-exists, vendor/sony/montblanc-common/montblanc-common-vendor.mk)

COMMON_PATH := device/sony/montblanc-common

# Common montblanc settings overlays
DEVICE_PACKAGE_OVERLAYS += $(COMMON_PATH)/overlay

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
    $(COMMON_PATH)/config/asound.conf:system/etc/asound.conf \
    $(COMMON_PATH)/config/hostapd.conf:system/etc/wifi/hostapd.conf \
    $(COMMON_PATH)/config/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(COMMON_PATH)/config/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf

# Media Codecs
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/config/media_codecs.xml:system/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    $(COMMON_PATH)/config/media_codecs_google_video_le.xml:system/etc/media_codecs_google_video_le.xml

# Custom init scripts
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/config/init.st-ericsson.rc:root/init.st-ericsson.rc \
    $(COMMON_PATH)/config/ueventd.st-ericsson.rc:root/ueventd.st-ericsson.rc

# Hardware configuration scripts
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/config/omxloaders:system/etc/omxloaders \
    $(COMMON_PATH)/config/ril_config:system/etc/ril_config \
    $(COMMON_PATH)/config/ste_setup.sh:system/bin/ste_setup.sh \
    $(COMMON_PATH)/config/ste_modem.sh:system/etc/ste_modem.sh \
    $(COMMON_PATH)/config/gps.conf:system/etc/gps.conf \
    $(COMMON_PATH)/config/cacert.txt:system/etc/suplcert/cacert.txt

# Copy input device configurations
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/config/sensor00_f11_sensor0.idc:system/usr/idc/sensor00_f11_sensor0.idc \
    $(COMMON_PATH)/config/synaptics_rmi4_i2c.idc:system/usr/idc/synaptics_rmi4_i2c.idc

# HAL
PRODUCT_PACKAGES += \
    sensors.montblanc

# Filesystem management tools
PRODUCT_PACKAGES += \
    setup_fs \
    fsck.f2fs \
    mkfs.f2fs
   
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
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.secure=0 \
    ro.adb.secure=0 \
    persist.service.adb.enable=1 \
    persist.service.debuggable=1

PRODUCT_PROPERTY_OVERRIDES += \
    persist.service.adb.enable=1 \
    persist.service.debuggable=1 \
    persist.sys.usb.config=mtp,adb

# Default USB configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.sys.usb.config=mtp

# Hardware-specific properties
PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.render_dirty_regions=false \
    persist.sys.bluetooth.handsfree=hfp_wbs \
    persist.sys.strictmode.disable=true \
    ro.opengles.version=131072 \
    ro.zygote.disable_gl_preload=true \
    sys.io.scheduler=row \
    wifi.interface=wlan0

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.ril_class=SonyU8500RIL \
    ro.telephony.ril.config=signalstrength \
    ro.telephony.call_ring.multiple=false

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    audio.offload.disable=1

# Force use old camera api
PRODUCT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1

