export CROSS_COMPILE=/home/balor/android/arm2009q3/bin/arm-none-eabi-
INITRAMFS_DIR=G1initramfs
make ARCH=arm distclean
make steve_defconfig
export KBUILD_BUILD_VERSION="balor_Beta_INTL"
export LOCALVERSION="-G1XXKPN-CL562447"
make ARCH=arm -j5
echo "Copy modules :"
find . -name "*.ko" ! -path "*$INITRAMFS_DIR*" -exec echo {} \;
find . -name "*.ko" ! -path "*$INITRAMFS_DIR*" -exec cp {} $INITRAMFS_DIR/lib/modules/  \;
make ARCH=arm -j5
cp arch/arm/boot/zImage .
tar cvf kernel.tar zImage
rm zImage
