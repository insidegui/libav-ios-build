# Libav-iOS-Build

Automatically builds libav as universal frameworks for iOS and iOS simulator.

## Usage

Make sure you have Xcode and It's command line tools installed before running this script.

### Step 1: Get a copy of libav

[Download the latest version of libav](https://libav.org/download/) (this script was last tested with version 12). Extract the zip/tarball.

### Step 2: Clone this repository

Clone this repo and copy all `.sh` files to the directory where you extracted libav.

	git clone https://github.com/insidegui/libav-ios-build.git

### Step 3: Customize build settings (OPTIONAL)

If you want to enable/disable features or customize other build settings, open the appropriate build script (`build_armv7`, `build_x86`, etc...) and change the settings you want. By default the frameworks are built with support for iOS 8.0 and up using the latest SDK available.

### Step 4: Run the script

Run `./BuildAllFrameworks.sh` and wait (it can take a long time, even on a powerful machine).

### Step 5: Use

The frameworks will be in the `Frameworks` folder, just link them to your iOS app and happy coding :)