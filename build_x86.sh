#!/bin/sh

make clean

./configure --cc=`xcrun -f --sdk iphonesimulator clang` \
	--arch=x86 \
	--cpu=generic \
	--sysroot=`xcrun --sdk iphonesimulator --show-sdk-path` \
	--target-os=darwin \
	--extra-cflags='-arch i386' \
	--extra-ldflags='-arch i386 -miphoneos-version-min=8.0' \
	--enable-cross-compile \
	--disable-programs --incdir=/ --libdir=/ --prefix=/

make
make install DESTDIR=tmpdir

mkdir tmpdir/i386
mv tmpdir/lib* tmpdir/i386/
rm -R tmpdir/pkgconfig