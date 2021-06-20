rm spi.img
CROSS_COMPILE=aarch64-linux-gnu- make clean
cp ~/trusted-firmware-a/build/rk3399/release/bl31/bl31.elf ./

# Here we build image with pcie
# CROSS_COMPILE=aarch64-linux-gnu- make roc-pc-mezzanine-rk3399_defconfig

# Here we build image without pcie
# CROSS_COMPILE=aarch64-linux-gnu- make roc-pc-rk3399_defconfig

# Here we build image which gets fucked up
CROSS_COMPILE=aarch64-linux-gnu- make fuck_defconfig

CROSS_COMPILE=aarch64-linux-gnu- make -j8
./tools/mkimage -n rk3399 -T rkspi -d tpl/u-boot-tpl.bin:spl/u-boot-spl.bin idbloader-spi.img
dd if=idbloader-spi.img of=spi.img
dd if=u-boot.itb of=spi.img bs=4096 seek=96
