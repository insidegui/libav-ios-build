#!/bin/sh

if gas-preprocessor.pl clang -v; then
	echo "gas-preprocessor is installed\n"
else
	echo "gas-preprocessor is not installed, downloading and installing..."
	
	if curl "https://git.libav.org/?p=gas-preprocessor.git;a=blob_plain;f=gas-preprocessor.pl;h=8eccc034325b2baa9212ffc10d8df73852f65201;hb=HEAD" > "./gas-preprocessor.pl"; then
		chmod +x "./gas-preprocessor.pl"
		sudo mv "./gas-preprocessor.pl" "/usr/bin/gas-preprocessor.pl"
		
		if gas-preprocessor.pl clang -v; then
			echo "gas-preprocessor installed successfully\n"
		else
			echo "Error installing gas-preprocessor"
			exit 1
		fi
	else
		echo "Error installing gas-preprocessor"
		exit 1
	fi
	
fi

if [ -a tmpdir ]; then
	rm -R tmpdir
fi

echo "Building architecture armv7...\n"
./build_armv7.sh

echo "Building architecture arm64...\n"
./build_arm64.sh

echo "Building architecture i386 (iOS simulator)...\n"
./build_x86.sh

echo "Building architecture x86_64 (iOS simulator)...\n"
./build_x86_64.sh

mkdir Frameworks
if [ -a ./Frameworks/*.framework ]; then
	rm -Rf ./Frameworks/*.framework
fi

mv library.mak bkp_library.mak
for lib in lib*; do
	mkdir -p ${lib}.framework/Headers
	lipo -create -arch arm ./tmpdir/arm/${lib}.a -arch arm64 ./tmpdir/arm64/${lib}.a -arch i386 ./tmpdir/i386/${lib}.a -arch x86_64 ./tmpdir/x86_64/${lib}.a -output ./${lib}.framework/${lib}
	cp -a ./tmpdir/arm/${lib}/* ${lib}.framework/Headers/
	mv ./*.framework ./Frameworks/
done
mv bkp_library.mak library.mak

echo "Done! You can find the universal frameworks in the Frameworks folder\n"

exit 0