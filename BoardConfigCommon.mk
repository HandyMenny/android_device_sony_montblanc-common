# Platform
TARGET_BOARD_PLATFORM := montblanc
TARGET_BOOTLOADER_BOARD_NAME := montblanc
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true
TARGET_SPECIFIC_HEADER_PATH += device/sony/montblanc-common/include
COMMON_GLOBAL_CFLAGS += -DSTE_HARDWARE
BOARD_USES_STE_HARDWARE := true

# Architecture
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := cortex-a9
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_HAVE_NEON := true

# Bionic flags
BOARD_USES_LEGACY_MMAP := true
TARGET_NEEDS_BIONIC_MD5 := true
MALLOC_IMPL := dlmalloc

# RIL implementation
BOARD_RIL_CLASS := ../../../device/sony/montblanc-common/telephony-common/

# Kernel information
BOARD_KERNEL_ADDRESS := 0x00008000
BOARD_RAMDISK_ADDRESS := 0x01000000
BOARD_KERNEL_BASE := 0x40200000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_ADDRESS)
BOARD_RECOVERY_BASE := 0x40200000
TARGET_KERNEL_SOURCE := kernel/sony/u8500
TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.8

# Bluetooth
BOARD_HAVE_BLUETOOTH := true

# Audio
COMMON_GLOBAL_CFLAGS += -DMR0_AUDIO_BLOB -DMR1_AUDIO_BLOB -DSTE_AUDIO
BOARD_HAVE_PRE_KITKAT_AUDIO_BLOB := true
BOARD_HAVE_PRE_KITKAT_AUDIO_POLICY_BLOB := true
BOARD_USES_ALSA_AUDIO := true
USE_LEGACY_AUDIO_POLICY := 1

# Wi-Fi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_cw1200
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_cw1200

# Camera
COMMON_GLOBAL_CFLAGS += -DICS_CAMERA_BLOB
TARGET_RELEASE_CPPFLAGS += -DNEEDS_VECTORIMPL_SYMBOLS

# Graphics
BOARD_EGL_CFG := device/sony/montblanc-common/config/egl.cfg
BOARD_EGL_NEEDS_FNW := true
USE_OPENGL_RENDERER := true
BOARD_EGL_WORKAROUND_BUG_10194508 := true

# Bootanimation optimization flags
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := false
TARGET_BOOTANIMATION_USE_RGB565 := true

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),userdebug)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif
DONT_DEXPREOPT_PREBUILTS := true

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT := true

# STE healthd HAL
BOARD_HAL_STATIC_LIBRARIES := libhealthd.montblanc

# Custom boot
BOARD_CUSTOM_BOOTIMG_MK := device/sony/montblanc-common/custombootimg.mk

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x01000000
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x01000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1056964608
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2147483648
BOARD_VOLD_MAX_PARTITIONS := 16
TARGET_USERIMAGES_USE_EXT4 := true

# Recovery
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_10x18.h\"
BOARD_HAS_NO_SELECT_BUTTON := true
COMMON_GLOBAL_CFLAGS += -DXPERIA_TWRP_TOUCH
RECOVERY_FSTAB_VERSION := 2
TARGET_RECOVERY_PIXEL_FORMAT := "RGB_565"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/musb-ux500.0/musb-hdrc/gadget/lun%d/file"
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_INTERNAL_STORAGE_PATH := "/sdcard"
TW_INTERNAL_STORAGE_MOUNT_POINT := "sdcard"
TW_HAS_NO_RECOVERY_PARTITION := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 255
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_INPUT_BLACKLIST := "lsm303dlhc_acc_lt\x0alsm303dlh_mag\x0al3g4200d_gyr"
TW_INCLUDE_FB2PNG := true
TW_NO_CPU_TEMP := true

# System proprieties
TARGET_SYSTEM_PROP := device/sony/montblanc-common/system.prop

# SELinux
BOARD_SEPOLICY_DIRS += device/sony/montblanc-common/sepolicy
BOARD_SEPOLICY_UNION += \
       admsrv.te \
       atd.te \
       bluetoothd.te \
       cn_server.te \
       conn_init.te \
       copsd.te \
       device.te \
       dhcp.te \
       hci_attach.te \
       hw_config.te \
       init.te \
       init_shell.te \
       iw.te \
       lbsd.te \
       modemcatcher.te \
       modem-supervisor.te \
       msa.te \
       psccd.te \
       rild.te \
       simd.te \
       simpbd.te \
       sms_server.te \
       suntrold.te \
       surfaceflinger.te \
       tad.te \
       updatemiscta.te \
       watchdogd.te \
       wpa.te
