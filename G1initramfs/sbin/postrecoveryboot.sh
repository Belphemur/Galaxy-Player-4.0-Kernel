#!/sbin/busybox sh

rm /etc
mkdir /etc
cat /res/etc/recovery.fstab > /etc/recovery.fstab

rm /sdcard
mkdir /sdcard
busybox mount -t vfat /dev/block/mmcblk0p1 /sdcard

rmdir /sdcard/external_sd
mkdir /sdcard/external_sd
busybox mount -t vfat /dev/block/mmcblk1p1 /sdcard/external_sd

rm -rf /sdcard/.android_secure
if [ -d /sdcard/external_sd/.android_secure ];
then
  mkdir /sdcard/.android_secure
  busybox mount --bind /sdcard/external_sd/.android_secure /sdcard/.android_secure
fi;

