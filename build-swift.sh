#!/bin/bash
set -e
source swift-define

# Build with SwiftPM
$SWIFT_NATIVE_PATH/swift build \
    --destination $SWIFTPM_DESTINATION_FILE \
    --package-path $SWIFT_PACKAGE_SRC
