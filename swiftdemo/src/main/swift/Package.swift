// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftdemo",
    products: [
        .library(name: "swiftdemo", type: .dynamic, targets: ["swiftdemotarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .branch("master")),
        .package(url: "git@github.com:PureSwift/AndroidBluetooth.git", .branch("master")),
        .package(url: "git@github.com:PureSwift/GATT.git", from: "2.1.1")
    ],
    targets: [
        .target(
            name: "swiftdemotarget",
            dependencies: ["Android", "AndroidBluetooth", "GATT"],
            path: "Sources"
        ),
    ]
)
