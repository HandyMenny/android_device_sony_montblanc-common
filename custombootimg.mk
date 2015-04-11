LOCAL_PATH := $(call my-dir)

uncompressed_ramdisk := $(PRODUCT_OUT)/ramdisk.cpio
$(uncompressed_ramdisk): $(INSTALLED_RAMDISK_TARGET)
	zcat $< > $@

MKELF := $(LOCAL_PATH)/tools/mkelf.py
INITSH := $(LOCAL_PATH)/recovery/init.sh
BOOTREC_DEVICE := device/sony/$(TARGET_DEVICE)/config/bootrec-device
BOOTREC_LED := device/sony/$(TARGET_DEVICE)/config/bootrec-led

INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img
$(INSTALLED_BOOTIMAGE_TARGET): $(PRODUCT_OUT)/kernel $(uncompressed_ramdisk) $(recovery_uncompressed_ramdisk) $(INSTALLED_RAMDISK_TARGET) $(INITSH) $(BOOTREC_DEVICE) $(BOOTREC_LED) $(PRODUCT_OUT)/utilities/busybox $(INTERNAL_BOOTIMAGE_FILES) $(PRODUCT_OUT)/utilities/extract_elf_ramdisk
	$(call pretty,"Boot image: $@")

	$(hide) rm -rf $(PRODUCT_OUT)/combinedroot
	$(hide) mkdir -p $(PRODUCT_OUT)/combinedroot/sbin

	$(hide) mv $(PRODUCT_OUT)/root/logo.rle $(PRODUCT_OUT)/combinedroot/logo.rle
	$(hide) cp $(uncompressed_ramdisk) $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) cp $(recovery_uncompressed_ramdisk) $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) cp $(PRODUCT_OUT)/utilities/busybox $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) cp  $(PRODUCT_OUT)/utilities/extract_elf_ramdisk $(PRODUCT_OUT)/combinedroot/sbin/

	$(hide) cp $(INITSH) $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) chmod 755 $(PRODUCT_OUT)/combinedroot/sbin/init.sh
	$(hide) ln -s sbin/init.sh $(PRODUCT_OUT)/combinedroot/init
	$(hide) cp $(BOOTREC_DEVICE) $(PRODUCT_OUT)/combinedroot/sbin/
	$(hide) cp $(BOOTREC_LED) $(PRODUCT_OUT)/combinedroot/sbin/

	$(hide) $(MKBOOTFS) $(PRODUCT_OUT)/combinedroot > $(PRODUCT_OUT)/combinedroot.cpio
	$(hide) cat $(PRODUCT_OUT)/combinedroot.cpio | gzip > $(PRODUCT_OUT)/combinedroot.fs
	$(hide) python $(MKELF) -o $(PRODUCT_OUT)/kernel.elf $(PRODUCT_OUT)/kernel@$(BOARD_KERNEL_ADDRESS) $(PRODUCT_OUT)/combinedroot.fs@$(BOARD_RAMDISK_ADDRESS),ramdisk $(LOCAL_PATH)/../$(TARGET_DEVICE)/config/cmdline@cmdline

	$(hide) dd if=$(PRODUCT_OUT)/kernel.elf of=$(PRODUCT_OUT)/kernel.elf.bak bs=1 count=44
	$(hide) printf "\x04" >$(PRODUCT_OUT)/04
	$(hide) cat $(PRODUCT_OUT)/kernel.elf.bak $(PRODUCT_OUT)/04 > $(PRODUCT_OUT)/kernel.elf.bak2
	$(hide) rm -rf $(PRODUCT_OUT)/kernel.elf.bak
	$(hide) dd if=$(PRODUCT_OUT)/kernel.elf of=$(PRODUCT_OUT)/kernel.elf.bak bs=1 skip=45 count=99
	$(hide) cat $(PRODUCT_OUT)/kernel.elf.bak2 $(PRODUCT_OUT)/kernel.elf.bak > $(PRODUCT_OUT)/kernel.elf.bak3
	$(hide) rm -rf $(PRODUCT_OUT)/kernel.elf.bak $(PRODUCT_OUT)/kernel.elf.bak2
	$(hide) cat $(PRODUCT_OUT)/kernel.elf.bak3 $(LOCAL_PATH)/../$(TARGET_DEVICE)/prebuilt/elf.3 > $(PRODUCT_OUT)/kernel.elf.bak
	$(hide) rm -rf $(PRODUCT_OUT)/kernel.elf.bak3
	$(hide) dd if=$(PRODUCT_OUT)/kernel.elf of=$(PRODUCT_OUT)/kernel.elf.bak2 bs=16 skip=79
	$(hide) cat $(PRODUCT_OUT)/kernel.elf.bak $(PRODUCT_OUT)/kernel.elf.bak2 > $(PRODUCT_OUT)/kernel.elf.bak3
	$(hide) rm -rf $(PRODUCT_OUT)/kernel.elf.bak $(PRODUCT_OUT)/kernel.elf.bak2 $(PRODUCT_OUT)/kernel.elf $(PRODUCT_OUT)/04
	$(hide) mv $(PRODUCT_OUT)/kernel.elf.bak3 $(PRODUCT_OUT)/boot.img
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
$(INSTALLED_RECOVERYIMAGE_TARGET): $(recovery_ramdisk) \
	$(recovery_kernel)
	@echo ----- Making recovery image ------
	$(hide) python $(MKELF) -o $(PRODUCT_OUT)/recovery.elf $(PRODUCT_OUT)/kernel@$(BOARD_KERNEL_ADDRESS) $(PRODUCT_OUT)/ramdisk-recovery.img@$(BOARD_RAMDISK_ADDRESS),ramdisk $(LOCAL_PATH)/../$(TARGET_DEVICE)/config/cmdline@cmdline

	$(hide) dd if=$(PRODUCT_OUT)/recovery.elf of=$(PRODUCT_OUT)/recovery.elf.bak bs=1 count=44
	$(hide) printf "\x04" >$(PRODUCT_OUT)/_04
	$(hide) cat $(PRODUCT_OUT)/recovery.elf.bak $(PRODUCT_OUT)/_04 > $(PRODUCT_OUT)/recovery.elf.bak2
	$(hide) rm -rf $(PRODUCT_OUT)/recovery.elf.bak
	$(hide) dd if=$(PRODUCT_OUT)/recovery.elf of=$(PRODUCT_OUT)/recovery.elf.bak bs=1 skip=45 count=99
	$(hide) cat $(PRODUCT_OUT)/recovery.elf.bak2 $(PRODUCT_OUT)/recovery.elf.bak > $(PRODUCT_OUT)/recovery.elf.bak3
	$(hide) rm -rf $(PRODUCT_OUT)/recovery.elf.bak $(PRODUCT_OUT)/recovery.elf.bak2
	$(hide) cat $(PRODUCT_OUT)/recovery.elf.bak3 $(LOCAL_PATH)/../$(TARGET_DEVICE)/prebuilt/elf.3 > $(PRODUCT_OUT)/recovery.elf.bak
	$(hide) rm -rf $(PRODUCT_OUT)/recovery.elf.bak3
	$(hide) dd if=$(PRODUCT_OUT)/recovery.elf of=$(PRODUCT_OUT)/recovery.elf.bak2 bs=16 skip=79
	$(hide) cat $(PRODUCT_OUT)/recovery.elf.bak $(PRODUCT_OUT)/recovery.elf.bak2 > $(PRODUCT_OUT)/recovery.elf.bak3
	$(hide) rm -rf $(PRODUCT_OUT)/recovery.elf.bak $(PRODUCT_OUT)/recovery.elf.bak2 $(PRODUCT_OUT)/recovery.elf $(PRODUCT_OUT)/_04
	$(hide) mv $(PRODUCT_OUT)/recovery.elf.bak3 $(PRODUCT_OUT)/recovery.img
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
