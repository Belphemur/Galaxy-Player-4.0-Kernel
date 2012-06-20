CROSS_COMPILE=/home/balor/android/arm2009q3/bin/arm-none-eabi-
INITRAMFS_DIR=G1initramfs
INITRAMFS_ROOT_DIR=../initramfs_yp-g1
KERNEL_NAME=TerraSilent
KERNEL_VNUMBER=1.3

# DO NOT MODIFY BELOW THIS LINE
CURRENT_DIR=`pwd`
NB_CPU=`grep processor /proc/cpuinfo | wc -l`
let NB_CPU+=1
if [[ -z $1 ]]
then
	echo "No configuration file defined"
	exit 1
	
else 
	if [[ ! -e "${CURRENT_DIR}/arch/arm/configs/$1" ]]
	then
		echo "Configuration file $1 don't exists"
		exit 1
	fi
	CONFIG=$1
fi


VERSION="intl"
echo "Cleaning directories"
rm -rf $INITRAMFS_DIR/*

echo "Copy default initramfs"
cp -R $INITRAMFS_ROOT_DIR/* $INITRAMFS_DIR/
echo "Copy configuration"
make $CONFIG
if [[ "$CONFIG" == *usa* ]]
then
	VERSION="usa"
fi
export KBUILD_BUILD_VERSION="${KERNEL_NAME}_${VERSION}-${KERNEL_VNUMBER}"
export LOCALVERSION="-G1XXKPN-CL562447"

echo "Build kernel ${KBUILD_BUILD_VERSION}${LOCALVERSION} with configuration $CONFIG"
make ARCH=arm -j$NB_CPU CROSS_COMPILE=$CROSS_COMPILE
echo "Copy modules :"
find . -name "*.ko" ! -path "*$INITRAMFS_DIR*" -exec echo {} \;
find . -name "*.ko" ! -path "*$INITRAMFS_DIR*" -exec cp {} $INITRAMFS_DIR/lib/modules/  \;

echo "Rebuild with modules"
make ARCH=arm -j$NB_CPU CROSS_COMPILE=$CROSS_COMPILE
cp "${CURRENT_DIR}/arch/arm/boot/zImage" .
TARFILE="${CURRENT_DIR}/${KBUILD_BUILD_VERSION}.tar"
if [[ -e $TARFILE ]]
then
	echo "Moving old tar file to ${TARFILE}.old"
	mv -f $TARFILE "${TARFILE}.old"
fi
tar cvf $TARFILE zImage
rm zImage
echo "Tar created : ${CURRENT_DIR}/${KBUILD_BUILD_VERSION}.tar"
