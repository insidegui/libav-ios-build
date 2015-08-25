#!/bin/sh

make clean

./configure --cc=`xcrun -f --sdk iphoneos clang` \
	--arch=armv7 \
	--cpu=cortex-a8 \
	--sysroot=`xcrun --sdk iphoneos --show-sdk-path` \
	--target-os=darwin \
	--extra-cflags='-arch armv7 -Wno-asm-operand-widths -integrated-as' \
	--extra-ldflags='-arch armv7 -miphoneos-version-min=8.0' \
	--enable-cross-compile --enable-pic \
	--disable-programs --incdir=/ --libdir=/ --prefix=/

make
make install DESTDIR=tmpdir

mkdir tmpdir/arm
mv tmpdir/lib* tmpdir/arm/
rm -R tmpdir/pkgconfig