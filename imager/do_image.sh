#!/bin/bash

source ./sources_path.sh

SCRIPT_PATH="$_PWD/../board/opendingux/gcw0/"
cd ../
$SCRIPT_PATH/build_mininit.sh

cd $_PWD

./create_mbr.sh
./create_system_image.sh
./create_data_image.sh
./assemble_images.sh
