#!/bin/sh

make clean

./configure --cc=`xcrun --sdk iphonesimulator clang` \
	--arch=x86_64 \
	--cpu=generic \
	--sysroot=`xcrun --sdk iphonesimulator --show-sdk-path` \
	--target-os=darwin \
	--extra-cflags='-arch x86_64' \
	--extra-ldflags='-arch x86_64 -miphoneos-version-min=8.0' \
	--enable-cross-compile \
	--disable-programs --incdir=/ --libdir=/ --prefix=/

make
make install DESTDIR=tmpdir

mkdir tmpdir/x86_64
mv tmpdir/lib* tmpdir/x86_64/
rm -R tmpdir/pkgconfig