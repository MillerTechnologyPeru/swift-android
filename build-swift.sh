XCTOOLCHAIN=/Library/Developer/Toolchains/swift-5.7.1-RELEASE.xctoolchain
SWIFT_SDK=swift-5.7.1-android-aarch64-24-sdk

# Create symbolic link
rm -rf ./swift/toolchain/$SWIFT_SDK/usr/lib/swift/clang
ln -sf /usr/lib/clang/13.0.0 \
    ./swift/toolchain/$SWIFT_SDK/usr/lib/swift/clang

# Generate SwiftPM destination file


# Build with SwiftPM
$XCTOOLCHAIN/usr/bin/swift build \
    --destination ./swift/toolchain/android-aarch64.json \
    --package-path ./swift