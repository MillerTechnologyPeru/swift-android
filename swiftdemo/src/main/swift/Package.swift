// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "swiftdemo",
    products: [
        .library(name: "swiftdemo", type: .dynamic, targets: ["swiftdemotarget"]),
    ],
    dependencies: [
        .package(url: "https://github.com/PureSwift/AndroidBluetooth.git", .branch("master")),
        .package(url: "https://github.com/PureSwift/Android.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "swiftdemotarget",
            dependencies: ["Android", "AndroidBluetooth"],
            path: "Sources"
        )
    ]
)
