mount -o rw,remount /data
MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug-pfsd.log
set -x

# run
FILE=$MODPATH/debug-boot-logcat.log
mv -f $FILE $FILE.bak
if grep ^killall $MODPATH/service.sh; then
  logcat > $FILE &
fi

# run
FILE=$MODPATH/debug-boot-dmesg.log
mv -f $FILE $FILE.bak
if grep ^killall $MODPATH/service.sh; then
  if [ -f /system/bin/dmesg ]; then
    /system/bin/dmesg -w > $FILE &
  elif [ -f /vendor/bin/dmesg ]; then
    /vendor/bin/dmesg -w > $FILE &
  elif [ -f /system/vendor/bin/dmesg ]; then
    /system/vendor/bin/dmesg -w > $FILE &
  else
    dmesg > $FILE
  fi
fi


