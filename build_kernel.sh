export CROSS_COMPILE=/home/balor/android/arm2009q3/bin/arm-none-eabi-
INITRAMFS_DIR=G1initramfs
INITRAMFS_ROOT_DIR=../initramfs_yp-g1

echo "Cleaning directories"
make ARCH=arm distclean
rm -rf $INITRAMFS_DIR/*

echo "Copy default initramfs"
cp -R $INITRAMFS_ROOT_DIR/* $INITRAMFS_DIR/
echo "Copy configuration"
make $1

export KBUILD_BUILD_VERSION="balor_Beta_INTL"
export LOCALVERSION="-G1XXKPN-CL562447"

echo "Build kernel $KBUILD_BUILD_VERSION $LOCALVERSION with configuration $1"
make ARCH=arm -j5
echo "Copy modules :"
find . -name "*.ko" ! -path "*$INITRAMFS_DIR*" -exec echo {} \;
find . -name "*.ko" ! -path "*$INITRAMFS_DIR*" -exec cp {} $INITRAMFS_DIR/lib/modules/  \;

echo "Rebuild with modules"
make ARCH=arm -j5
cp arch/arm/boot/zImage .
tar cvf kernel.tar zImage
rm zImage
