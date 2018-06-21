#!/system/bin/sh
# By Rom
INIT=/system/etc/init.d
FHISTORY=$INIT/FileHistory.txt
FHISTORYNEW=$INIT/FileHistory.new.txt
DIFF=$INIT/diff.txt
LASTCHCKFILE=$INIT/Lastchk.txt
EXSDCARD_LABEL=`blkid -s LABEL | cut -d "\"" -f2 | tail -1`
EXSD=/storage/$EXSDCARD_LABEL

if [ -d /system ] && [ -d /data ] && [ -d /storage ]; then
	[ ! -a "$FHISTORYNEW" ] | touch $FHISTORYNEW; fi
	if [ -a $FHISTORY ] ; then
		ls -da /data/media/obb/*/**.obb > $FHISTORYNEW
   fi
		
fi

comm -2 -3 $FHISTORY $FHISTORYNEW > $DIFF

rm -f $FHISTORY
mv $FHISTORYNEW $FHISTORY
fi

while [ 1 ]; do
	if [ `sys.boot_completed` = 1 ]; then sleep 40
		if [ ! -a "$MODDIR/$i" ] && [ -d "$EXSD" ]; then
			service call statusbar 1
			for i in printf '%s\n' "$DIFF" | while IFS= read -r line
				do mv "$i" "$EXSD"
				ln -s "$i" "$EXSD/$i"
				printf "$i" >> $FHISTORYNEW
			fi
	done

service call statusbar 2

rm -f $FHISTORY
mv $FHISTORYNEW $FHISTORY
