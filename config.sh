##########################################################################################
#
# Magisk Module Template Config Script
# by topjohnwu
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure the settings in this file (config.sh)
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
#
##########################################################################################

##########################################################################################
# Configs
##########################################################################################

# Set to true if you need to enable Magic Mount
# Most mods would like it to be enabled
AUTOMOUNT=true

# Set to true if you need to load system.prop
PROPFILE=false

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=true

##########################################################################################
# Installation Message
##########################################################################################

# Set what you want to show when installing your mod

print_modname() {
  ui_print "--------------------------------"
  ui_print "ExSDCard OBB Linker"
  ui_print "LP to Oreo support"
  ui_print "For Magisk v15+"
  ui_print "By Rom"
  ui_print "--------------------------------"
}

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info about how Magic Mount works, and why you need this

# This is an example
REPLACE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here, it will override the example above
# !DO NOT! remove this if you don't need to replace anything, leave it empty as it is now
REPLACE="
"

##########################################################################################
# Permissions
##########################################################################################

set_permissions() {
  # Only some special files require specific permissions
  # The default permissions should be good enough for most cases

  # Here are some examples for the set_perm functions:

  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm_recursive  $MODPATH/system/lib       0       0       0755            0644

  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  # set_perm  $MODPATH/system/bin/app_process32   0       2000    0755         u:object_r:zygote_exec:s0
  # set_perm  $MODPATH/system/bin/dex2oat         0       2000    0755         u:object_r:dex2oat_exec:s0
  # set_perm  $MODPATH/system/lib/libart.so       0       0       0644

  # The following is default permissions, DO NOT remove
  set_perm_recursive  $MODPATH  0  0  0755  0644
}

##########################################################################################
# Custom Functions
##########################################################################################

# This file (config.sh) will be sourced by the main flash script after util_functions.sh
# If you need custom logic, please add them here as functions, and call these functions in
# update-binary. Refrain from adding code directly into update-binary, as it will make it
# difficult for you to migrate your modules to newer template versions.
# Make update-binary as clean as possible, try to only do function calls in it.

sdcard_detection() {
	echo "Detecting External SDCard informations.."
	EXSDCARD_LABEL=`blkid -s LABEL | cut -d "\"" -f2 | tail -1`
	EXSDCARD_NAME=`cat /proc/mounts | grep /storage/ | sed '1d' | awk '{ print $2 }' | sed '2d' | sed 's/\/storage\///'`
	EXSDCARD_TYPE=`blkid-s TYPE | cut -d "\"" -f2 | tail -1`
	TMPDIR=/dev/tmp
	MOUNTPATH=$TMPDIR/magisk_img
	MODID=`grep_prop id $INSTALLER/module.prop`
	INSTALLER=$TMPDIR/install
	MODPATH=$MOUNTPATH/$MODID
	
	[ "$EXSDCARD_LABEL" = "$EXSDCARD_NAME" ] | echo -e "Your External SDCard has been detected\nName: $EXSDCARD_LABEL\nPartition format: $EXSDCARD_TYPE" || echo "You don't have External SDCard on your device or it don't work propeply" && exit 1
	
	echo "$EXSDCARD_LABEL" > "$MODPATH/SD_label"
	echo "$EXSDCARD_TYPE" > "$MODPATH/SD_type"
}


toybox_check() {
	TOYBOXPATH=/system/bin/toybox
	if [ -a "$BINPATH" ]; then
		exit 0
	else
		case $ARCH in /system/bin/toybox
			arm64*) cp $MODPATH/toybox-aarch64 $TOYBOXPATH && chmod 0644 $TOYBOXPATH;;
			arm*) cp $MODPATH/toybox-armv7m $TOYBOXPATH && chmod 0644 $TOYBOXPATH;;
			x86_64*) cp $MODPATH/toybox-x86_64 $TOYBOXPATH && chmod 0644 $TOYBOXPATH;;
			x86*) cp $MODPATH/toybox-x86 $TOYBOXPATH && chmod 0644 $TOYBOXPATH;;
			mips64*) cp $MODPATH/toybox-mips64 $TOYBOXPATH && chmod 0644 $TOYBOXPATH;;
			mips*) cp $MODPATH/toybox-mips $TOYBOXPATH && chmod 0644 $TOYBOXPATH;;
			*) echo "Unknow architecture: $abi"; abort;;
		esac;
	ui_print "Installing Toybox file using architecture: $arch";
}


install_instant_works() {
ln -sf $MODPATH/EOL /data/media/eol
}


module_works() {
for i in /data/media/obb/*/; do mv $i /storage/$EXSDCARD_LABEL/Android/obb/; ln -n /storage/$EXSDCARD_LABEL/Android/obb/$i /data/media/obb/$i; done
		
for x in /storage/emulated/0/obb/*/; do mv $x /storage/$EXSDCARD_LABEL/Android/obb/; ln -n /storage/$EXSDCARD_LABEL/Android/obb/$x /storage/emulated/0/obb/$s; done
}
