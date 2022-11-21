#!/bin/bash
set -e
source swift-define

# Build with SwiftPM
$SWIFT_NATIVE_PATH/swift build \
    --destination $SWIFTPM_DESTINATION_FILE \
    --package-path $SWIFT_PACKAGE_SRC

# Copy compiled Swift package
mkdir -p $SRC_ROOT/app/src/main/jniLibs/arm64-v8a/
cp -rf $SWIFT_PACKAGE_SRC/.build/aarch64-unknown-linux-android24/debug/libSwiftAndroidApp.so \
    $SRC_ROOT/app/src/main/jniLibs/arm64-v8a/
# Copy Swift StdLib and Foundation
cp -rf $SWIFT_SDK_PATH/usr/lib/swift/android/*.so \
    $SRC_ROOT/app/src/main/jniLibs/arm64-v8a/
# Copy C stdlib
cp -rf $SWIFT_SDK_PATH/usr/lib/libc++_shared.so \
    $SRC_ROOT/app/src/main/jniLibs/arm64-v8a/