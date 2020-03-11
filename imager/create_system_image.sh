#!/bin/bash

source ./sources_path.sh
source ./partition_layout.sh

if ! which mcopy > /dev/null
then
	echo "Please install the 'mtools' package."
	exit 1
fi

echo "Checking presence of kernel files..."
if test -f $VMLINUZ_BIN_PATH
then
	SIZE=$(stat -Lc %s $VMLINUZ_BIN_PATH)
	echo "$VMLINUZ_BIN: $((${SIZE} / 1024)) kB"
else
	echo "missing main kernel: $VMLINUZ_BIN"
	exit 1
fi

echo "Checking presence of $MININIT_SYSPART..."
if test -f $MININIT_SYSPART_PATH
then
	SIZE=$(stat -Lc %s $MININIT_SYSPART_PATH)
	echo "$MININIT_SYSPART: $((${SIZE} / 1024)) kB"
else
	echo "missing program: $MININIT_SYSPART"
	exit 1
fi

echo "Checking presence of root filesystem..."
if test -f $ROOTFS_PATH
then
	SIZE=$(stat -Lc %s $ROOTFS_PATH)
	echo "$ROOTFS: $((${SIZE} / 1024)) kB"
else
	echo "missing root filesystem: $ROOTFS"
	exit 1
fi

echo "Checking presence of modules filesystem..."
if test -f $MODULES_PATH
then
	SIZE=$(stat -Lc %s $MODULES_PATH)
	echo "$MODULES: $((${SIZE} / 1024)) kB"
else
	echo "missing modules filesystem: $MODULES"
	exit 1
fi

echo "Creating system partition..."
IMAGE_SIZE=$((${DATA_START} - ${SYSTEM_START}))
mkdir -p images
dd if=/dev/zero of=images/system.bin bs=512 count=${IMAGE_SIZE} status=noxfer
/sbin/mkdosfs -s 8 -F 32 images/system.bin
echo

echo "Populating system partition..."
mmd -i images/system.bin ::dev ::root
mcopy -i images/system.bin $VMLINUZ_BIN_PATH ::$VMLINUZ_BIN
sha1sum $VMLINUZ_BIN_PATH | cut -d' ' -f1 | mcopy -i images/system.bin - ::$VMLINUZ_BIN.sha1
mcopy -i images/system.bin $MININIT_SYSPART_PATH ::$MININIT_SYSPART
sha1sum $MININIT_SYSPART_PATH | cut -d' ' -f1 | mcopy -i images/system.bin - ::$MININIT_SYSPART.sha1
mcopy -i images/system.bin $MODULES_PATH ::$MODULES
sha1sum $MODULES_PATH | cut -d' ' -f1 | mcopy -i images/system.bin - ::$MODULES.sha1
mcopy -i images/system.bin $ROOTFS_PATH ::$ROOTFS
sha1sum $ROOTFS_PATH | cut -d' ' -f1 | mcopy -i images/system.bin - ::$ROOTFS.sha1

echo "Minimizing image size..."
./trimfat.py images/system.bin
