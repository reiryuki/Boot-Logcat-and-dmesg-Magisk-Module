MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug.log
set -x

# wait
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 1
done

# stop
killall logcat dmesg


