#!/bin/bash
set -e
source swift-define

# Build with SwiftPM
export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
$SWIFT_NATIVE_PATH/swift build \
    --destination $SWIFTPM_DESTINATION_FILE \
    --package-path $SWIFT_PACKAGE_SRC
