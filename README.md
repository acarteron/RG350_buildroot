# RG350 VGA support

## WARNING
This release support VGA resolution with JT035IPS02-V0 screen only, original RG350 screen is not supported in this release.

Also it is based on latest commits on tonyjih's repositories (kernel and buildroot). Thus it is probably very unstable.

It includes a custom version of esoteric with VGA resolution support.

## TO DO
- [ ] update esoteric icons to match with vga resolution

## Instructions:<br>

Releases:

https://github.com/acarteron/RG350_buildroot/releases/tag/VGA-testing

## NOTE: This method erases the microsd, so backup of all your files.
1. Download the base system "sd_image.bin" from the Releases page.

### **for Windows:<br>**
2. Format the new sdcard / internal sdcard with SD FORMATTER 5.0.1 ( https://www.sdcard.org/downloads/formatter/ ) two times.
3. Flash the FW base image in the SD card with Balena Etcher ( https://www.balena.io/etcher/ ).
4. DO NOT RESIZE THE EXT4 PARTITION IN WINDOWS OR LINUX!!<br> Just put the sdcard inside the console, it resize partition automatically.

### **for Linux:<br>**
2. Format the new SD card / internel SD card with gnome-disk-utility.
3. Flash the FW base image in the SD card with Balena Etcher ( https://www.balena.io/etcher/ ).
   Or type in a terminal:
   
   sudo dd if=sd_image.bin of=/dev/[SD card mount point]
4. Do not resize the partitions!! <br> Just put the sdcard inside the console, it resize partition automatically.


## Build instructions
```
make rg350_vga_defconfig BR2_EXTERNAL=board/opendingux
make
cd imager
./do_image.sh
```

## Repositories
RG350_linux: https://github.com/acarteron/RG350_linux/tree/480p

RG350_buildroot: https://github.com/acarteron/RG350_buildroot

Esoteric: https://github.com/acarteron/esoteric

GMenu2X: https://github.com/acarteron/RG350-gmenu2x

o2xiv: https://github.com/acarteron/o2xiv.git
