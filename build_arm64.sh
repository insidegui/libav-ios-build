#!/bin/sh

make clean

./configure --cc=`xcrun -f --sdk iphoneos clang` \
	--arch=aarch64 \
	--cpu=generic \
	--sysroot=`xcrun --sdk iphoneos --show-sdk-path` \
	--target-os=darwin \
	--extra-cflags='-arch arm64' \
	--extra-ldflags='-arch arm64 -miphoneos-version-min=8.0' \
	--enable-cross-compile --disable-programs --incdir=/ --libdir=/ --prefix=/

make
make install DESTDIR=tmpdir

mkdir tmpdir/arm64
mv tmpdir/lib* tmpdir/arm64/
rm -R tmpdir/pkgconfig