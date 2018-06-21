#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode
# More info in the main Magisk thread
SDLABEL=`cat $MODPATH/SD_label`
SDTYPE=`cat $MODPATH/SD_type`

while [ 1 ]; do
	if [ `sys.boot_completed` = 1 ]; then am start -a android.intent.action.VIEW -d file:///$MODDIR/START_shape_of_you.mp3
	
		for dir in /data/media/obb/*/; [ ! -L "$dir" ] | ln -n /storage/$EXSDCARD_LABEL/Android/obb/$i /data/media/obb/$i; done
		for dir in /storage/emulated/0/obb/*/; [ ! -L "$dir" ] | ln -n /storage/$EXSDCARD_LABEL/Android/obb/$x /storage/emulated/0/obb/$s; done
	
	am start -a android.intent.action.VIEW -d file:///$MODDIR/FINISH_whistle_of_love.mp3
	
done


