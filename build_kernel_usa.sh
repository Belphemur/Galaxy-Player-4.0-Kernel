export CROSS_COMPILE=/home/klin1344/android/arm-2009q3/bin/arm-none-eabi-
INITRAMFS_DIR=G1initramfs
make steve_usa_defconfig
export KBUILD_BUILD_VERSION="klin_Beta_US"
export LOCALVERSION="-G1XXKPN-CL562447"
make -j2
cp crypto/ansi_cprng.ko $INITRAMFS_DIR/lib/modules/
cp drivers/scsi/scsi_wait_scan.ko $INITRAMFS_DIR/lib/modules/
cp drivers/net/wireless/bcm4329/dhd.ko $INITRAMFS_DIR/lib/modules/
cp drivers/misc/vibetonz/vibrator.ko $INITRAMFS_DIR/lib/modules/
cp drivers/misc/fm_si4709/Si4709_driver.ko $INITRAMFS_DIR/lib/modules/
cp drivers/bluetooth/bthid/bthid.ko $INITRAMFS_DIR/lib/modules/
make -j2
cp arch/arm/boot/zImage .
tar cvf kernel.tar zImage
rm zImage
