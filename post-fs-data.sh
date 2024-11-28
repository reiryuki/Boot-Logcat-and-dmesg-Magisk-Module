mount -o rw,remount /data
MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug-pfsd.log
set -x

# dmesg
dmesg > $MODPATH/debug-boot-dmesg.log

# run
FILE=$MODPATH/debug-boot-logcat.log
rm -f $FILE
if grep '^killall logcat' $MODPATH/service.sh; then
  logcat > $FILE &
fi


