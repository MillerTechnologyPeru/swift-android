#!/bin/bash
set -e
source swift-define

# Generate SwiftPM destination file
$SRC_ROOT/generate-swiftpm-toolchain.sh

# Create symbolic link to clang
rm -rf $SRC_ROOT/swift/toolchain/$SWIFT_SDK/usr/lib/swift/clang
ln -sf $XCTOOLCHAIN/usr/lib/clang/13.0.0 \
    $SRC_ROOT/swift/toolchain/$SWIFT_SDK/usr/lib/swift/clang

# Install macOS dependencies
if [[ $OSTYPE == 'darwin'* ]]; then
    echo "Install macOS build dependencies"
    HOMEBREW_NO_AUTO_UPDATE=1 brew install wget cmake ninja android-ndk

    # Verify toolchain installed
    if [ ! -d ${XCTOOLCHAIN} ]
    then
        echo "Please install the swift-5.7.1-RELEASE toolchain (or set XCTOOLCHAIN)"
        echo "On Mac: https://download.swift.org/swift-5.7.1-release/xcode/swift-5.7.1-RELEASE/swift-5.7.1-RELEASE-osx.pkg"
        exit 1
    fi
fi

# Check swift-autolink-extract exists
if [[ ! -f "${XCTOOLCHAIN}/usr/bin/swift-autolink-extract" ]];
then
    echo "Missing symlink '${XCTOOLCHAIN}/usr/bin/swift-autolink-extract'."
    echo "We need 'sudo' permission to create it (just this once)."
    sudo ln -s swift ${XCTOOLCHAIN}/usr/bin/swift-autolink-extract || exit 1
fi
