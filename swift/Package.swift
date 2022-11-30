// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SwiftAndroidApp",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftAndroidApp",
            type: .dynamic,
            targets: ["SwiftAndroidApp"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/Android.git",
            branch: "master"
        ),
        .package(
            url: "https://github.com/PureSwift/AndroidBluetooth.git",
            branch: "master"
        ),
        .package(
            url: "https://github.com/PureSwift/JavaCoder.git",
            branch: "master"
        )
    ],
    targets: [
        .target(
            name: "SwiftAndroidApp",
            dependencies: [
                "Android",
                "AndroidBluetooth",
                "JavaCoder"
            ]
        ),
    ]
)
