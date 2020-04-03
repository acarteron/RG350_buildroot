#!/bin/bash

_PWD=`pwd`
BUILT_PATH="$_PWD/../output/images"

VMLINUZ_BIN=vmlinuz.bin
VMLINUZ_BIN_PATH="$BUILT_PATH/$VMLINUZ_BIN"

MININIT_SYSPART=mininit-syspart
MININIT_SYSPART_PATH="$BUILT_PATH/$MININIT_SYSPART"

ROOTFS=rootfs.squashfs
ROOTFS_PATH="$BUILT_PATH/$ROOTFS"

MODULES=modules.squashfs
MODULES_PATH="$BUILT_PATH/$MODULES"

UBIBOOT=ubiboot-rg350.bin
UBIBOOT_PATH="$BUILT_PATH/ubiboot/$UBIBOOT"